# frozen_string_literal: true

class AddressesController < ApplicationController
  def index; end

  def create
    ap address_params
  end

  private

  def address_params
    params.permit(:address, :lat, :lng, :zip)
  end
end
