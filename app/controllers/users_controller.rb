class UsersController < ApplicationController
  # 管理者専用の登録アクション
  def new_admin
    @user = User.new
  end

  def create_admin
    @user = User.new(user_params)
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

  def user_params
    params.require(:user).permit(:name, :password, :admin)
  end
end
