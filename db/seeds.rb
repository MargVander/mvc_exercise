# frozen_string_literal: true

1.upto(3) do |i|
  Category.create!(
    name: Faker::Food.dish,
    description: Faker::Food.description
  )
  p "CATEGORY #{i} : créé"
end

1.upto(10) do |i|
  Item.create!(
    original_price: Faker::Number.decimal(2),
    name: Faker::Food.fruits,
    category: Category.all.sample
  )
  p "ITEM #{i} : créé"
end
