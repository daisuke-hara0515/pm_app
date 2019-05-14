require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do #homeページのテスト
    get static_page_home_url 
    #Getリクエストをstaticpageコントローラーのhomeアクションに対して発行
    assert_response :success
    #リクエストに対するレスポンスは成功するはず
  end

  test "should get help" do
    get static_page_help_url
    assert_response :success
  end

end
