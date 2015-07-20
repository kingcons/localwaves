class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :access_token
      t.string :password

      t.timestamps null: false
    end
    add_index :users, :username
    add_index :users, :email
    add_index :users, :access_token
  end
end
