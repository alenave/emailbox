class Message < ApplicationRecord
  belongs_to :user
  belongs_to :message_thread
  has_many :message_thread_participants
  has_many :message_user_mappings
end
