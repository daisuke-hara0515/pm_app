class User < ApplicationRecord
    before_save { email.downcase! } #ユーザーをデータベースに保存する前にこのメソッドが実行される。downcase!は破壊的メソッド
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true,length: {maximum: 255},
               format: {with: VALID_EMAIL_REGEX},
               uniqueness: {case_sensitive: false } 
               #case_sensitiveオプションは、大文字小文字を区別するかどうかのオプションでデフォルトはtrue（区別する）
    has_secure_password #ハッシュ化パスワードが利用できるようになる
    validates :password, presence: true, length: { minimum: 6 }

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
end
