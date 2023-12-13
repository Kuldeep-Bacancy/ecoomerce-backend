# frozen_string_literal: true

class BaseController < ApplicationController
  include JsonWebToken

  before_action :authenticate_request

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      return render_401 unless token.present?

      current_customer_token(token)
    rescue (JWT::ExpiredSignature || JWT::DecodeError)
      render_401
    end
  end

  def current_customer_token(token)
    return render_401 if BlacklistToken.find_by(token:)

    decoded = jwt_decode(token)
    @current_customer_id = decoded[:customer_id]
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: @current_customer_id)
  end
end
