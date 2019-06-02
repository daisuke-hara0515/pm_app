require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "daisuke hara", email: "test@example.com")
  end

  test "should be valid" do
    assert @user.valid? #@userが有効かどうかのテスト
  end

  test "name should be present" do
    @user.name = "" #@userのnameを空白にする
    assert_not @user.valid? #@userが有効では無いかどうかのテスト
  end

  test "email should be present" do
    @user.email = " " #@userのemailが空白
    assert_not @user.valid?  #@userが有効では無いことをテスト
  end
end
