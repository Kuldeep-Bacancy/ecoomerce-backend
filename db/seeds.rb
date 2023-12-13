# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

p 'Seeding data start-----------------------------------------------------'

%w[Electronics Grocery Clothes].each do |name|
  Category.find_or_create_by(name:)
end

30.times do
  Product.find_or_create_by(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: rand(1000..5000),
    category_id: rand(1..3)
  )
end

p 'Seeding data completed-----------------------------------------------------'
