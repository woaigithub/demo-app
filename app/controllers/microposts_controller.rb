class MicropostsController < ApplicationController
  before_filter :signed_in_user, :only => [:create, :destroy]
  before_filter :correct_user, :only => :destroy

  def index

  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = current_user.microposts.build(params[:micropost])

    if @micropost.save
      flash[:success]="micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'staticpages/home'
    end
  end


  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_to root_path
  end

  private
  def correct_user
    @micropost=current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
