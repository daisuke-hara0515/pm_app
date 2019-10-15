class UserMailer < ApplicationMailer

  def account_activation(user) #アクティベート化メールアクション
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user) #パスワードリセットアクション
    @user = user
    mail to:user.email, subject: "Password reset"
  end
end
