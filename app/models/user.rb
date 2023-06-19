class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 管理者かどうかの判定メソッド
  def admin?
    admin
  end

  has_one_attached :profile_picture

  validates :name, presence: true
  validates :birthday, presence: true
end
