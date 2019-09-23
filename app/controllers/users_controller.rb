class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "カロリーマネージメントへようこそ！"
      redirect_to @user #redirect_to user_url(@user)と等価のコード
      #if @user.saveがtrueであるかどうか。falseならnewページをrenderする
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name,:email,:password,
                      :password_confirmation)
    end
end
