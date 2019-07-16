require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get login_path #ログインURLへgetリクエストを出す
    assert_template 'sessions/new' #sessionコントローラのnewアクション(newがレンダリングされているか)ができているか確認
    post login_path, params: {session: {email: "",password: ""}} #フォームに無効なemailとパスワードをpostする
    assert_template 'sessions/new' #セッションがまた表示されるか確認
    assert_not flash.empty? #かつフラッシュメッセージが追加されていること
    get root_path
    assert flash.empty? #homeなどに移った際にフラッシュメッセージが消えていることを確認
  end
end
