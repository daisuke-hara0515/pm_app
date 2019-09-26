require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
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

end
