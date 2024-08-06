class Api::V1::RoadTripController < ApplicationController
  def create
    facade = RoadTripFacade.new
    if User.find_by(api_key: params[:api_key]) != nil
      road_trip = facade.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: ErrorSerializer.new(ErrorMessage.new("bad credentials", 401)).serialize_json, status: :unauthorized
    end
  end
end