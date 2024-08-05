class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: ErrorSerializer.new(ErrorMessage.new("bad credentials", 401)).serialize_json, status: :unauthorized
    end
  end
end