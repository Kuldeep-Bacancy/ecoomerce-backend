class ProductsController < BaseController
  skip_before_action :authenticate_request

  def index
    pagy, products = pagy(Product.includes(:category, :images_attachments).all)
    render_products(products, pagy)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :price, images: [])
  end

  def render_products(products, pagy)
    pagination = pagy_metadata(pagy)
    serialized_data = serialize_products(products, pagination)
    render_json('Products fetched successfully!', { products: serialized_data[:data], meta: serialized_data[:meta] })
  end

  def serialize_products(products, pagy)
    ProductSerializer.new(products, pagination_hash(pagy)).serializable_hash
  end

  def pagination_meta(pagy)
    {
      count: pagy[:count],
      items: pagy[:vars][:items],
      current_page: pagy[:page],
      prev: pagy[:prev].to_s,
      next: pagy[:next].to_s,
      first_url: pagy[:first_url],
      last_url: pagy[:last_url],
      prev_url: pagy[:prev_url].to_s,
      next_url: pagy[:next_url].to_s
    }
  end

  def pagination_hash(pagy)
    { meta: { pagination: pagination_meta(pagy) } }
  end
end
