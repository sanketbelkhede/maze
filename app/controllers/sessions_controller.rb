class SessionsController < ApplicationController
  def new
    @user = User.new
    if session[:user_id] != nil
      flash.now[:notice] = "Sign Out before you Sign In again"
      render :warning
    end
    
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      if @user.active?
        if @user.is_password?(user_params[:password])
          session[:user_id] = @user.id
          # SessionNotifierMailer.send_signin_email(@user).deliver
          # SendSigninJob.perform_later(@user)
          flash[:notice] = "Sign In Successful"
          redirect_to articles_path
        else
          flash[:notice] = "Invalid email or password"
          redirect_to sessions_path
        end
      else
        flash[:notice] = "Account Blocked"
          redirect_to sessions_path
      end
    else
      flash[:notice] = "Invalid email or password"
      redirect_to sessions_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed Out Successfully"
    redirect_to new_user_path
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
