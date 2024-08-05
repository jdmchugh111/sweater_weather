class Api::V1::UsersController < ApplicationController
  def create
    facade = UsersFacade.new
    user = facade.create_user(params[:email], params[:password], params[:password_confirmation])
    if user.id != nil
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.new(ErrorMessage.new(user.errors, 400)).serialize_json, status: :bad_request
    end
  end
end