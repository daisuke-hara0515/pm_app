require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
        assert_equal full_title,"CalorieManage App"
        assert_equal full_title("Help"),"Help|CalorieManage App"
    end
end