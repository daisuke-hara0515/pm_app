module UsersHelper

    #引数で与えられたユーザーのGravatar画像を返す
    def gravatar_for(user,size: 80)
        #DigestライブラリのhexdigestメソッドでMD5を使ってハッシュ
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        #gravatar_idの値が代入され、そのURLがgravatar_url
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}? s=#{size}"
        image_tag(gravatar_url,alt: user.name, class: "gravatar")
    end
end
