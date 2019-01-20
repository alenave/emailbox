class MessageUserMapping < ApplicationRecord
  belongs_to :user
  belongs_to :message
  belongs_to :tag
end
