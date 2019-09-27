require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  
  test "should get signup" do
    get signup_url
    assert_response :success
  end

  #ログイン前の状態で、@userのedit画面にアクセスした際に、flashエラーが出るかとログインページに飛ぶか
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  #ログインしていない状態でアップデートをしようとすると、ログインページに強制送還
  test "should redirect update when not logged in" do
    patch user_path(@user),params: {user:{name:@user.name,
                           email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  #他のユーザーが自分のユーザーを編集できないかを確認するテスト
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user),params: {user:{name: @user.name,
                          email: @user.email}}
    assert flash.empty?
    assert_redirected_to root_url
  end

end
