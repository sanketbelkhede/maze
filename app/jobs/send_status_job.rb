class SendStatusJob < ApplicationJob
    queue_as :default
    def perform(current_user)
        StatusOfUploadedUsersMailer.send_status_email(current_user).deliver
    end

end
