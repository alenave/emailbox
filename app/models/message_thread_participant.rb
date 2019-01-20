class MessageThreadParticipant < ApplicationRecord
  belongs_to :message_thread
  belongs_to :message
  belongs_to :user
end
