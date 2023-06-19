class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  # 管理者専用の登録アクション
  def new_admin
    @user = User.new
  end

  def create_admin
    @user = User.new(admin_params)
    @user.admin = true

    if @user.save
      # 保存が成功した場合の処理
      redirect_to root_path, notice: '管理者アカウントが作成されました。'
    else
      # 保存が失敗した場合の処理
      render :new_admin
    end
  end

  private

  def admin_params
    params.require(:user).permit(:name, :password, :admin)
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
