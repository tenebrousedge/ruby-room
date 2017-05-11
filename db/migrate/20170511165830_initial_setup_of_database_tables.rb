class InitialSetupOfDatabaseTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      t.column :name, :string
      t.column :password, :string

      t.timestamps
    end

    create_table(:messages) do |t|
      t.column :content, :text
      t.column :user_id, :integer

      t.timestamps
    end
  end
end
