class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: User.pluck(:email_id, :id)
  end

  def show
    render json: User.find(params[:id]).messages
  end

  def create
    user_creator = Services::UserCreator.new(sanitize_user_params)
    return render json: { success: true }, status: :created if user_creator.process
    render json: { sucess: false, message: user_creator.errors.full_messages.first }, status: :unprocessable_entity
  end

  private

  def sanitize_user_params
    params.permit(:email_id, :username, :first_name, :last_name)
  end
end
