class UserNotifierMailer < ApplicationMailer
    default :from => 'sanket.belkhede@jarvis.consulting'
    
    def send_signup_email(user)
        @user = user
        mail( :to => @user.email,
        :subject => 'Thanks for signing up for our amazing app' )
    end

end