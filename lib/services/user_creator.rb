module Services
  class UserCreator
    include ActiveModel::Validations

    validates :email_id, :username, :first_name, :last_name, presence: true

    def initialize(params)
      @email_id = params[:email_id]
      @username = params[:username]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
    end

    def process
      return unless valid?
      ActiveRecord::Base.transaction do
        create_user
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      false
    end

    private

    attr_reader :email_id, :username, :first_name, :last_name

    def create_user
      User.create!(email_id: email_id, username: username, first_name: first_name, last_name: last_name)
    end
  end
end
