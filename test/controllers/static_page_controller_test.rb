require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "CalorieManage App"
  end

  test "should get root" do #rootページのテスト
    get root_url #rootページにアクセス
    assert_response :success #rootページにアクセスできたら
  end

  test "should get home" do #homeページのテスト
    get static_page_home_url 
    #Getリクエストをstaticpageコントローラーのhomeアクションに対して発行
    assert_response :success
    #リクエストに対するレスポンスは成功するはず
    assert_select "title","CalorieManage App"
    #テンプレート内のタイトルタグにCalorieManage Appが存在するか
  end

  test "should get help" do
    get static_page_help_url
    assert_response :success
    assert_select "title","Help|#{@base_title}"
  end

  test "should get about" do
    get static_page_about_url
    assert_response :success
    assert_select "title","About|#{@base_title}"
  end
end
