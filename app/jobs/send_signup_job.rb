class SendSignupJob < ApplicationJob
    queue_as :default
    def perform(user)
        UserNotifierMailer.send_signup_email(user).deliver
    end

end
