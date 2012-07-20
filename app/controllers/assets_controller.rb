class AssetsController < ApplicationController
  before_filter :authenticat_user!
  
  def index
    @assets = current_user.assets
  end

  def show
    @assets = current_user.assets.find(params[:id])
  end

  def new
    @assets = current_user.assets.new
  end

  def create
   @assets = current_user.assets.new(params[:asset])
    if @asset.save
      redirect_to @asset, :notice => "Successfully created asset."
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = @assets = current_user.assets.find(params[:id])
  end

  def update
    @asset = @assets = current_user.assets.find(params[:id])
    if @asset.update_attributes(params[:asset])
      redirect_to @asset, :notice  => "Successfully updated asset."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset = @assets = current_user.assets.find(params[:id])
    @asset.destroy
    redirect_to assets_url, :notice => "Successfully destroyed asset."
  end
end
