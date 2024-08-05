class Api::V1::ForecastController < ApplicationController
  rescue_from NoMethodError, with: :bad_request_error
  def index
    facade = ForecastFacade.new
    forecast = facade.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end

  private

  def bad_request_error(exception)
    render json: ErrorSerializer.new(ErrorMessage.new("Param missing", 400)).serialize_json, status: :bad_request
  end
end