class AssetsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @assets = current_user.assets
  end

  def get
    @asset = current_user.assets.find_by_id(params[:id])
    if @asset
      # needs to be updated to use X-Sendfile apache module (https://tn123.org/mod_xsendfile/)
      # instructions on how to use X-Sendfile with Rails : http://www.therailsway.com/2009/2/22/file-downloads-done-right/
      send_file @asset.uploaded_file.path, :type => @asset.uploaded_file_content_type
    else
      flash[:error] = "Don't be cheeky, mind your own assets!"
      redirect_to assets_path
    end
      
  end
  
  def show
    @asset = current_user.assets.find(params[:id])
  end

  def new
    @asset = current_user.assets.build
    if params[:folder_id] # if we want to upload a file inside another folder_id
      @current_folder = current_user.folders.find(params[:folder_id])
      @asset.folder_id = @current_folder.id
    end
  end

  def create
   @asset = current_user.assets.new(params[:asset])
    if @asset.save
      flash[:notice] = "Successfully uploaded file"
      
      if @asset.folder # checking if we have a parent folder for this file
        redirect_to browse_path(@asset.folder) #then we redirect to the parent folder
      else
        redirect_to root_url
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = current_user.assets.find(params[:id]) 
  end

  def update
   @asset = current_user.assets.find(params[:id])
    if @asset.update_attributes(params[:asset])
      redirect_to @asset, :notice  => "Successfully updated asset."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset = current_user.assets.find(params[:id]) 
    @asset.destroy
    redirect_to assets_url, :notice => "Successfully destroyed asset."
  end
end
