# frozen_string_literal: true

class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :price

  attribute :category do |obj|
    obj&.category&.name
  end

  attribute :images do |obj|
    obj.product_images&.pluck(:image)
  end
end
