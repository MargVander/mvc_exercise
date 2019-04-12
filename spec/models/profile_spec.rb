# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Model instantiation' do
    subject(:new_profile) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to belong_to :user }
    end
  end

  describe 'Valid with valid attributes' do
    context 'when the category has valid attribute' do
      it { expect(build(:profile)).to be_valid }
    end
  end
end
