require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "index including pagenation" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index' #users/indexテンプレートが選択されているか
    assert_select 'div.pagination',count:2 #<div class="pagination">foobar</div>にマッチするものがあるか
    User.paginate(page: 1).each do |user| #User.paginate(page:1)の戻り値に対してeachメソッド
      assert_select 'a[href=?]',user_path(user),text: user.name #<a href="users/User_id">user.name</a>にマッチするものがあるか
    end
  end
end
