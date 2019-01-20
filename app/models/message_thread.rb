class MessageThread < ApplicationRecord
  has_many :messages
  has_many :message_thread_participants
end




