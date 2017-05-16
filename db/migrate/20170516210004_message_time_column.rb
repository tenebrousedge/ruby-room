class MessageTimeColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :display_time, :string
  end
end
