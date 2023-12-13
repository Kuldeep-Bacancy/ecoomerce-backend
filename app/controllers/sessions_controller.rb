# frozen_string_literal: true

class SessionsController < BaseController
  skip_before_action :authenticate_request, only: [:login]

  def login
    customer = Customer.find_by_email(signin_params[:email])
    if customer&.authenticate(signin_params[:password])
      render_json('Sign in successfully', { email: customer.email, token: jwt_encode(customer_id: customer.id) })
    else
      render json: { status: 'Non-Authoritative Information', message: ['You entered in an incorrect email or password,please try again.'], data: [], status_code: 203, messageType: 'error' },
             status: 203
    end
  end

  def logout
    token = request.headers['Authorization']&.split(' ')&.last
    if token.present?
      BlacklistToken.find_or_create_by(customer_id: current_customer.id, token:)
      render_json('Logout Successfully!')
    else
      render_401
    end
  end

  private

  def signin_params
    params.require(:customer).permit(:email, :password)
  end
end
