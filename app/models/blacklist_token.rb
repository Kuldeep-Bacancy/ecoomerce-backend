# frozen_string_literal: true

class BlacklistToken < ApplicationRecord
  belongs_to :customer
end
