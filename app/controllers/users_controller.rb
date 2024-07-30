class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_events = @user.events
  end
end
