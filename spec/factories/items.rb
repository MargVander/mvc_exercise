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

FactoryBot.define do
  factory :item do
    original_price      { Faker::Number.decimal(2) }
    has_discount        { Faker::Boolean.boolean }

    trait :with_discount do
      has_discount { true }
    end

    factory :item_with_discount, traits: %i[with_discount]
  end
end
