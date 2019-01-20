class User < ApplicationRecord
  has_many :message_thread_participants
  has_many :message_user_mappings
  has_many :messages, through: :message_user_mappings
  has_many :message_threads, through: :messages
end
