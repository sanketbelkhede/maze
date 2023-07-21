class StatusOfUploadedUsersMailer < ApplicationMailer
    default :from => 'sanket.belkhede@jarvis.consulting'
    
    def send_status_email(current_user)
        @user = current_user
        mail( :to => @user.email,
        :subject => 'Upload Successful.' )
    end

end