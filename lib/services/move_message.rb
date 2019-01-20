module Services
  class MoveMessage
    def initialize(params, tag_name)
      @user_id = params[:user_id]
      @tag_name = tag_name
      @message_id = params[:message_id]
    end

    def process
      move_message
    end

    private

    attr_reader :tag_name, :message_id, :user_id

    def move_message
      MessageUserMapping.where(message: messages, user_id: user_id).update_all(tag_id: tag)
    end

    def messages
      MessageThread.find(Message.find(message_id).message_thread_id).messages
    end

    def tag
      Tag.find_by(name: tag_name)
    end
  end
end
