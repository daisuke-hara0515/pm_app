module ApplicationHelper
    #ページ毎の完全なタイトルを返します。
    def full_title(page_title = '')
        base_title = "PocketMoney App" #base_titleが"PocketMoney App"という文字が定義されている
        if page_title.empty? #full_titleメソッドの引数が空白かどうか
            base_title
        else
            page_title + "|" +base_title
        end
    end
end
