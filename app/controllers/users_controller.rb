class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @events = Event.all
  end

private

  def user_params
    params.require(:user).permit(:email, :description, :first_name, :last_name, :encrypted_password)
  end
end
