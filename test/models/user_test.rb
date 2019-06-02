require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
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

  test "name should not be too long" do
    @user.name = "a" * 51 #@userのnameの文字数が51文字
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
              first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                  foo@bar_baz.com foo@bar+baz.com foo@bar..com] #有効ではなさそうなアドレス達を%wで配列に変換
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
