class AddActivityToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activity, :boolean
  end
end
