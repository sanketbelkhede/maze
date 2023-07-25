require 'csv'
class UsersController < ApplicationController
  def index
    @users = User.includes(:articles, :comments, :likes)
  end

  def download_csv
    users = User.includes(:articles, :comments, :likes)
    csv_data = CSV.generate do |csv|
        csv << ['Name', 'Articles', 'Comments', 'Likes']
        users.each do |user|
          csv << [user.name, user.articles.count, user.comments.count, user.likes.count]
        end
    end
    send_data csv_data, filename: 'users.csv'
  end

  def download_10_csv
    user1s = User.joins(:articles).group('users.id').having('COUNT(articles.id) > ?', 1)
    csv_data = CSV.generate do |csv|
      csv << ['Name', 'Articles', 'Comments', 'Likes']
      user1s.each do |user|
        csv << [user.name, user.articles.count, user.comments.count, user.likes.count]
      end
    end
    send_data csv_data, filename: 'users10.csv'
  end

  def download_xlsx
    users = User.includes(:articles, :comments, :likes)
    csv_data = CSV.generate do |csv|
        csv << ['Name', 'Articles', 'Comments', 'Likes']
        users.each do |user|
            csv << [user.name, user.articles.count, user.comments.count, user.likes.count]
        end
    end
    send_data csv_data, filename: 'users.xlsx'
  end

  def new
    @user = User.new
    if session[:user_id] != nil
      flash.now[:notice] = "Sign Out before you register"
      render :warning
    end
  end

  def create
    @user = User.new(user_params)
    @user.name = "#{params[:user][:firstname]} #{params[:user][:lastname]}"
    if @user.save
      # UserNotifierMailer.send_signup_email(@user).deliver
      # SendSignupJob.perform_later(@user)
      redirect_to sign_in_path, notice: "User was successfully created."
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :mobile)
  end



end
