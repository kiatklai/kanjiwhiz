class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:show, :edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user.id)
      bypass_sign_in(user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:profile_picture, :birthday, :password, :password_confirmation)
  end

  def ensure_current_user
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to root_path
    end
  end
end
