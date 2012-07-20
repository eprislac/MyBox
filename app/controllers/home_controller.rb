class HomeController < ApplicationController
  def index
    if user_signed_in?
      # load the current user's folders
      @folders = current_user.folders.order("name desc")
      
      # load the current user's files (assets)
      @assets = current_user.assets.order("uploaded_file_file_name desc")
    end
  end
end
