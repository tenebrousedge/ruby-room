class CreateTableBannedUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address, :string

    create_table :exiles do |t|
      t.string :username
      t.string :address
    end
  end
end
