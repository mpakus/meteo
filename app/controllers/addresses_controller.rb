# frozen_string_literal: true

class AddressesController < ApplicationController
  def index; end

  def create
    case address_created?
    in { address: }
      if address.weather.need_update?
        @address = Address::UpdateWeather.new(address.id).perform
      else
        @from_cache = true
        @address    = address
      end
    in { error: }
      logger.error "Address creation failed: #{error}"
      render :index, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.permit(:address, :lat, :lng, :zip)
  end

  def address_created?
    Address::Create
      .new(params[:address], params[:lat], params[:lng], params[:zip])
      .perform
  end
end
