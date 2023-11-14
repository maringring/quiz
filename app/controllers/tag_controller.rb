class TagController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
  end

  def create
    @tags = Tag.create(name: params[:tag_name])
    
    redirect_to tag_index_path
  end

  def edit
    @tags = Tag.find(params[:id])
  end

  def update
    @tags = Tag.find(params[:id])
    @tags.update(name: params[:tag_name])

    redirect_to tag_index_path
  end

  def destroy
    @tags = Tag.find(params[:id])
    @tags.destroy

    redirect_to tag_index_path
  end

end
