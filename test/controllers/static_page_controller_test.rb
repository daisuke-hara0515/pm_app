require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "CalorieManage App"
  end

  test "should get home" do #homeページのテスト
    get root_path 
    #Getリクエストをstaticpageコントローラーのhomeアクションに対して発行
    assert_response :success
    #リクエストに対するレスポンスは成功するはず
    assert_select "title","CalorieManage App"
    #テンプレート内のタイトルタグにCalorieManage Appが存在するか
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title","Help|#{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title","About|#{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title","Contact|#{@base_title}"
  end
end
