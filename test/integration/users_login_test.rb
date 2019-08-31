require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path #ログインURLへgetリクエストを出す
    assert_template 'sessions/new' #sessionコントローラのnewアクション(newがレンダリングされているか)ができているか確認
    post login_path, params: {session: {email: "",password: ""}} #フォームに無効なemailとパスワードをpostする
    assert_template 'sessions/new' #セッションがまた表示されるか確認
    assert_not flash.empty? #かつフラッシュメッセージが追加されていること
    get root_path
    assert flash.empty? #homeなどに移った際にフラッシュメッセージが消えていることを確認
  end

  test "login with valid information" do
    get login_path
    post login_path, params:{session:{email: @user.email,
                                          password:'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path,params: {session:{email: @user.email,
                           password: 'password'}}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]",login_path,count:0
    assert_select "a[href=?]",logout_path
    assert_select "a[href=?]",user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]",login_path
    assert_select "a[href=?]",logout_path, count:0
    assert_select "a[href=?]",user_path(@user), count:0
  end
end
