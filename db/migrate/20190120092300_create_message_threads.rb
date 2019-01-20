class CreateMessageThreads < ActiveRecord::Migration[5.0]
  def change
    create_table :message_threads do |t|
      t.string :subject

      t.timestamps
    end
  end
end
