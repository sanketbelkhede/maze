class SendSigninJob < ApplicationJob
    queue_as :default
    def perform(user)
        SessionNotifierMailer.send_signin_email(user).deliver
    end

end
