class Tag < ApplicationRecord
  module Name
    INBOX = 'Inbox'.freeze
    SENT = 'Sent'.freeze
    DRAFT = 'Draft'.freeze
    TRASH = 'Trash'.freeze
  end
end
