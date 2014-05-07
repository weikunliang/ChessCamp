class UsersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :check_login, only: [:edit, :update, :destroy]
  authorize_resource

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, :notice => 'User was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to home_path, :notice => 'User was successfully updated.'
    else
      render :action => "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :instructor_id, :role, :active, :password, :password_confirmation)
  end
end