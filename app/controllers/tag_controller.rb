class TagController < ApplicationController
  before_action :find_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
  end

  def create
    @tag = Tag.create(name: params[:tag_name])
    
    redirect_to tag_index_path
  end

  def edit
  end

  def update
    @tag.update(name: params[:tag_name])

    redirect_to tag_index_path
  end

  def destroy
    @tag.destroy

    redirect_to tag_index_path
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end

end
