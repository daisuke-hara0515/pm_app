require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do #homeページのテスト
    get static_page_home_url 
    #Getリクエストをstaticpageコントローラーのhomeアクションに対して発行
    assert_response :success
    #リクエストに対するレスポンスは成功するはず
    assert_select "title","Home | PocketMoney App"
    #テンプレート内のタイトルタグにHome | PocketMoney Appが存在するか
  end

  test "should get help" do
    get static_page_help_url
    assert_response :success
    assert_select "title","Help | PocketMoney App"
  end

  test "should get about" do
    get static_page_about_url
    assert_response :success
    assert_select "title","About | PocketMoney App"
  end
end
