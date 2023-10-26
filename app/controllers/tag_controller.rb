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

  def create_tag
    # @tag =
    # tag_list = params[:question][:tag].split(',') # viewでカンマ区切りで入力してもらうことで、入力された値をsplit(',')で配列にしている。
      
    # if @questions.save
    #     @questions.save_tags(tag_list) # save_tagsというインスタンスメソッドを使って保存している。
    #     flash[:alert] = "プロフィールの設定が完了しました"

    #     redirect_to admins_index_path
    # else
    #   redirect_to admins_new_path
    # end
  end
end
