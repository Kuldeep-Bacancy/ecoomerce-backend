# frozen_string_literal: true

class RegistrationsController < BaseController
  skip_before_action :authenticate_request, only: [:signup]

  def signup
    customer = Customer.new(sign_up_params)
    if customer.valid?
      customer.save
      render_json('Sign up successfully', { email: customer.email })
    else
      render_422(customer.errors.full_messages)
    end
  end

  private

  def sign_up_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password)
  end
end
