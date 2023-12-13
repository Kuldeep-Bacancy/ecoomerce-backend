# frozen_string_literal: true

class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :category

  def product_images
    images.map { |img| { image: img.url } }
  end
end
