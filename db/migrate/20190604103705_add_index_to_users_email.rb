class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true #emailカラムがuniqueである（true）でことをオプションハッシュで指定
  end
end
