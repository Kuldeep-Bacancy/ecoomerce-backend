# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApplicationErrors
  include Pagy::Backend

  def index
    render_404
  end
end
