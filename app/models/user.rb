class User < ApplicationRecord
    attr_accessor :remember_token,:activation_token
    before_save :downcase_email #ユーザーをデータベースに保存する前にこのメソッドが実行される。downcase!は破壊的メソッド
    before_create :create_activation_digest
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true,length: {maximum: 255},
               format: {with: VALID_EMAIL_REGEX},
               uniqueness: {case_sensitive: false } 
               #case_sensitiveオプションは、大文字小文字を区別するかどうかのオプションでデフォルトはtrue（区別する）
    has_secure_password #ハッシュ化パスワードが利用できるようになる
    validates :password, presence: true, length: { minimum: 6 },allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token #記憶トークンの作成（生データ）
      SecureRandom.urlsafe_base64
    end

    def remember
      self.remember_token = User.new_token #selfはremember_token=のようなセッターメソッドを呼んでいる
      update_attribute(:remember_digest, User.digest(remember_token)) #remember_digestカラムの記憶ダイジェストを更新する。
    end

    def authenticated?(attribute,token)
      digest = self.send("#{attribute}_digest")
      return false if digest.nil? #記憶ダイジェストがnilの場合、falseを返す
      BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
      update_attribute(:remember_digest,nil)
    end

    private

    def downcase_email
      email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  end
