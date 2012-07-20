class FoldersController < ApplicationController
  before_filter :authenticate_user! 
  def index
   @folders = current_user.folders
  end

  def show
    @folder = current_user.folders.find(params[:id])
  end

  def new
  
    @folder = current_user.folders.new
    
    #if there is a "folder_id" param, we know that we are under a folder, thus, we will essentially create a subfolder
    if params[:folder_id] # if we want to create a folder inside another folder
      
      # We still need to set the @current_folder to make the buttons work correctly
      @current_folder = current_user.folders.find(params[:folder_id])
      
      # Then, we make sure the folder we are creating has a parent folder which is the @current_folder
      @folder.parent_id = @current_folder.id
      
    end
  end

  def create
    @folder = current_user.folders.new(params[:folder])
    if @folder.save
      
      if @folder.parent # Checking if we have a parent folder on this one
        redirect_to browse_path(@folder.parent), :notice => "Successfully created folder." # Then we redirect to the parent folder
      else
        redirect_to root_url, :notice => "Successfully created folder." #if not, redirect back to home page 
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @folders = current_user.folders.find(params[:id])
  end

  def update
 @folders = current_user.folders.find(params[:id])
    if @folder.update_attributes(params[:folder])
      redirect_to @folder, :notice  => "Successfully updated folder."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @folders = current_user.folders.find(params[:id])
    @folder.destroy
    redirect_to folders_url, :notice => "Successfully destroyed folder."
  end
end
