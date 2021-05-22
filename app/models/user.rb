class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  with_options presence: true do
    validates :birthday

    with_options format:{ with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/} do
      validates :password
      validates :password_confirmation
    end

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龠々ー]+\z/} do
      validates :last_name, presence: true
      validates :first_name, presence: true
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/} do
      validates :last_name_kana, presence: true
      validates :first_name_kana, presence: true
    end
  end
end
