# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  discount_percentage :integer          default(0)
#  has_discount        :boolean          default(FALSE)
#  name                :string
#  original_price      :float            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  category_id         :bigint(8)
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(presence: true) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(presence: true) }
      it { is_expected.to validate_inclusion_of(:discount_percentage).in_range(0..100) }
      it { is_expected.to belong_to :category }
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end
  end

  describe 'Valid with valid attributes' do
    context 'when the item has valid attribute' do
      it { expect(build(:item)).to be_valid }
    end
  end

  describe 'Unvalid with unvalid attributes' do
    context 'when discount_percentage is above 100' do
      let(:item) { build(:item, original_price: 100.00, discount_percentage: 150) }

      it { is_expected.not_to be_valid }
    end

    context 'when discount_percentage is below 100' do
      let(:item) { build(:item, original_price: 100.00, discount_percentage: -50) }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'Average method' do
    it "returns the item: average_price" do
      create(:item, original_price: 100.00)
      create(:item, original_price: 50.00)

      expect(Item.average_price).to eq(75.00)
    end
  end
end
