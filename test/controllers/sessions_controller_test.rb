require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success #:successはステータスコード200〜299を指定している（成功ステータス）
  end

end
