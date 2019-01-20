module Services
  class MessageCreator
    include ActiveModel::Validations

    validates :to, presence: true

    def initialize(params)
      @subject = params[:subject]
      @body = params[:body]
      @to = params[:to].split(',')
      @sender_id = params[:sender_id]
      @new_thread = params[:new_thread].to_s == 'true'
      @message_id = params[:message_id]
    end

    def process
      return unless valid?
      ActiveRecord::Base.transaction do
        create_message_thread
        create_message_thread_participant
        create_message
        create_message_user_mapping
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      false
    end

    private

    attr_reader :subject, :body, :parent_email_id, :sender_id, :message, :to, :message_thread, :new_thread, :message_id

    def create_message_thread
      @message_thread =  if new_thread
                            MessageThread.create!(subject: subject)
                         else
                            Message.find(message_id).message_thread
                         end
    end

    def create_message_thread_participant
      users.each do |u|
        MessageThreadParticipant.where(message_thread: message_thread, user: u).first_or_create
      end
    end

    def create_message
      @message = Message.create!(user: sender, body: body, message_thread: message_thread)
    end

    def create_message_user_mapping
      users.each do |u|
        MessageUserMapping.create!(user: u, message: message, tag: tag)
      end
    end

    def tag
      Tag.find_by(name: Tag::Name::INBOX)
    end

    def users
      email_ids = to << sender.email_id
      @users ||= User.where(email_id: email_ids)
    end

    def sender
      @sender ||= User.find(sender_id)
    end
  end
end
