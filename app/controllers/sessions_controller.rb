class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password]) #if @userがtrueだったら右辺を評価する、authenticatedメソッドは引数に渡されたパスワードをハッシュ化して、password_digestと比較する
      if @user.activated?
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user) #rememberメソッドは記憶トークンを作成し、ダイジェストをデータベースに保存する。
      redirect_back_or @user
    else
      message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
    end
  else
    flash.now[:danger] = 'Eメールまたはパスワードが正しくありません'
    render 'new'
  end
end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end