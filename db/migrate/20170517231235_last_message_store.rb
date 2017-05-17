class LastMessageStore < ActiveRecord::Migration[5.1]
  def change
    create_table :last_messages do |t|
      t.column :message_id, :string
    end
  end
end
