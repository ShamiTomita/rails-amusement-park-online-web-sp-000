class UsersController < ApplicationController
skip_before_action :verified_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if (user = User.create(user_params))
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :height, :tickets, :nausea, :happiness, :admin)
  end


end
