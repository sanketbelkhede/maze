class SessionNotifierMailer < ApplicationMailer
    default :from => 'sanket.belkhede@jarvis.consulting'

    def send_signin_email(user)
        @user = user
        mail( :to => @user.email,
        :subject => 'Signed In successfully' )
    end

end