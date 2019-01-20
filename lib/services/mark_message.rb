module Services
  class MarkMessage
    def initialize(pramas)
      @toggle = pramas[:toggle].to_s == 'true'
      @message_id = pramas[:message_id]
      @user_id = pramas[:user_id]
    end

    def process
      mark
    end

    private

    attr_reader :message_id, :toggle, :user_id

    def mark
      MessageUserMapping.where(message: messages, user_id: user_id).update_all(is_read: toggle)
    end

    def messages
      MessageThread.find(Message.find(message_id).message_thread_id).messages
    end
  end
end
