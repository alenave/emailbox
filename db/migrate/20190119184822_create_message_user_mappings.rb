class CreateMessageUserMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :message_user_mappings do |t|
      t.references(:message, index: true)
      t.references(:user, index: true)
      t.references(:tag, index: true)
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
