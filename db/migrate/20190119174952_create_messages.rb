class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :body
      t.references(:user, index: true)
      t.references(:message_thread, index: true)
      t.timestamps
    end
  end
end
