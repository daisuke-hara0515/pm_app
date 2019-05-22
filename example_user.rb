class User
    attr_accessor :name, :email
    #インスタンス変数@nameと@emailにアクセスするためのメソッドが用意される

    def initialize(attributes = {}) #attributes変数は空のハッシュをデフォルトで持つ
      @name = attributes[:name]
      @email = attributes[:email]
    end

    def formatted_email
        "#{@name}<#{@email}>"
    end
end

