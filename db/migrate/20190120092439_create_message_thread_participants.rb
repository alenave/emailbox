class CreateMessageThreadParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :message_thread_participants do |t|
      t.references(:message_thread, index: true)
      t.references(:user, index: true)

      t.timestamps
    end
  end
end
