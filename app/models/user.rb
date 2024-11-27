class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  
  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'パスワードは半角英字と半角数字の両方を含めて設定してください'}
  validates :nickname, presence: true
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角ひらがな、全角カタカナ、漢字で入力して下さい' } do
    validates :last_name
    validates :first_name
  end
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}ー－]+\z/, message: '全角カタカナのみを使用してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}ー－]+\z/, message: '全角カタカナのみを使用してください'}
  validates :date_of_birth, presence: true
  
end
