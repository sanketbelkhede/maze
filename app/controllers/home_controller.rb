class HomeController < ApplicationController
  def index
    if !current_user.nil?
      flash[:notice] = "Signed In"
      redirect_to articles_path
    end
  end
end
