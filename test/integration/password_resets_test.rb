require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path,params: {password_reset:{email:""}} #メアド無効(空送信)
    assert_not flash.empty?
    assert_template 'password_resets/new' #password_reset_controllerのnewメソッド
    post password_resets_path,
      params: {password_reset:{email:@user.email}} #有効かメアド送る
    assert_not_equal @user.reset_digest,@user.reload.reset_digest
    assert_equal 1,ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    user = assigns(:user) #パスワード再設定のフォームテスト
    get edit_password_reset_path(user.reset_token,email:"") #トークンが無効
    assert_redirected_to root_url
    user.toggle!(:activated) #無効なユーザー
    get edit_password_reset_path(user.reset_token,email:user.email)
    assert_redirected_to root_url
    user.toggle!(:activated) #toggleメソッドは属性を反転させる　例）false→true
    get edit_password_reset_path('wrong token',email: user.email) #メアドが有効、トークンが無効
    assert_redirected_to root_url
    get edit_password_reset_path(user.reset_token,email:user.email) #メアドもトークンも有効
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]",user.email #inputタグに正しい名前、type="hidden"、メアドがあるか確認
    patch password_reset_path(user.reset_token),
      params:{email:user.email,
           user:{password: "foobaz",
               password_confirmation: "barquux"}}
    assert_select 'div#error_explanation'
    patch password_reset_path(user.reset_token), #パスワードが空
      params:{email:user.email,
           user:{password: "",
               password_confirmation: ""}}
    assert_select 'div#error_explanation'
    patch password_reset_path(user.reset_token), #有効なパスワードとパスワード確認
      params:{email:user.email,
           user:{password: "foobaz",
               password_confirmation: "foobaz"}}
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
