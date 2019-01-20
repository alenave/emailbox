class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show_all
    render json: { response: MessageThreadParticipant.find_by(user_id: params[:id]) }, status: :ok
  end

  def show
    render json: {
      response: MessageThread.find(Message.find(params[:id]).message_thread_id).messages.pluck(:id, :body)
    },
           status: :ok
  end

  def trash
    move_email = Services::MoveMessage.new(params, Tag::Name::TRASH)
    return render json: { success: true } if move_email.process
    render json: { success: false }
  end

  def sent
    move_email = Services::MoveMessage.new(params, Tag::Name::SENT)
    return render json: { success: true } if move_email.process
    render json: { success: false }
  end

  def draft
    move_email = Services::MoveMessage.new(params, Tag::Name::DRAFT)
    return render json: { success: true } if move_email.process
    render json: { success: false }
  end

  def inbox
    move_email = Services::MoveMessage.new(params, Tag::Name::DRAFT)
    return render json: { success: true } if move_email.process
    render json: { success: false }
  end

  def mark
    mark_message = Services::MarkMessage.new(params)
    return render json: { success: true } if mark_message.process
    render json: { success: false }
  end

  def create
    message_creator = Services::MessageCreator.new(sanitize_email_params)
    return render json: { success: true }, status: :created if message_creator.process
    render json: { success: false, message: message_creator.errors.full_messages.first }, status: :unprocessable_entity
  end

  private

  def sanitize_email_params
    params.permit(:subject, :body, :to, :sender_id, :new_thread, :message_id)
  end
end
