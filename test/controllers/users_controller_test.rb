require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @non_activated_user = users(:non_activated)
  end

  #ログインしていないユーザーが/usersをgetしたらログインページに飛ぶかのテスト
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
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

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user),params: {
                     user: {password: @other_user.password,
                           password_confirmation: @other_user.password,
                           admin: true }}
    assert_not @other_user.reload.admin?
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

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should not allow the not activated attribute" do
    log_in_as(@non_activated_user)
    assert_not @non_activated_user.activated?
    get users_path
    assert_select "a[href=?]", user_path(@non_activated_user), count: 0
    get user_path(@non_activated_user)
    assert_redirected_to root_url
  end

  #work outページへ飛ぶかどうかのテスト
  test "should redirect work out page" do
  
end

