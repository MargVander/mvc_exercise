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

class Item < ApplicationRecord
  validates :discount_percentage, inclusion: 0..100
  validates :original_price, presence: true
  belongs_to :category

  def price
    if has_discount == true
      original_price - (original_price * (discount_percentage.to_f / 100)).round(2)
    else
      original_price
    end
  end

  def self.average_price
    prices_list = []
    find_each do |item|
      prices_list << item.price
    end
    prices_list_sum = prices_list.inject(:+)
    prices_list_sum / prices_list.length
  end
end
