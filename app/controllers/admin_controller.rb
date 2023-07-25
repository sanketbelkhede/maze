class AdminController < ApplicationController
    before_action :require_admin
    before_action :user_params, only: %i[ create_user ]


    def index
        @users = User.includes(:articles, :comments, :likes)
        @articles = Article.all
        @article = Article.new
    end

    def import
        file = params[:file]
    
        file = File.open(file)
        csv = CSV.parse(file, headers: true)
        csv.each do |row|
          user_hash = {}
          user_hash[:email] = row["Email"]
          User.create(user_hash)
        end
        
        # StatusOfUploadedUsersMailer.send_status_email(current_user).deliver
        # SendStatusJob.perform_later(current_user)
        redirect_to admin_path, notice: "Users imported!"
    end

    def activate_user
        user = User.find(params[:id])
        user.update(active: true)
        redirect_to admin_path, notice: "User activated successfully."
    end

    def deactivate_user
        user = User.find(params[:id])
        user.update(active: false)
        redirect_to admin_path, notice: "User deactivated successfully."
    end

    def new
        @user = User.new
    end
    
    def create_user
        @user = User.new(user_params)
        @user.name = "#{params[:user][:firstname]} #{params[:user][:lastname]}"
        if @user.save
            redirect_to admin_manage_users_path, notice: "User created successfully."
        else
            flash[:notice] = @user.errors.full_messages.to_sentence
            redirect_to admin_create_user_new_path
        end
    end

    def manage_users
        @users = User.all
    end

    private

        def require_admin
            redirect_to articles_path unless current_user&.admin?
        end

        def user_params
            params.require(:user).permit(:email, :firstname, :lastname,:mobile, :admin)
        end

end
