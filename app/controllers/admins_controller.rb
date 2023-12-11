class AdminsController < ApplicationController
  before_action :set_qid, only: [:show, :edit, :update, :destroy] 
  before_action :set_tag, only: [:index, :new, :create, :edit, :update] 
  before_action :set_qsimil, only: [:show, :destroy] 

  def set_qid
    @question = Question.find(params[:id])
  end

  def set_tag
    @tags = Tag.all
  end

  def set_qsimil
    @question_similar_word = @question.question_similar_words
  end


  def index
    @questions = Question.all
    @question_similar_word = QuestionSimilarWord.all
    @question_tags = @questions.map { |q| q.tags }
  end

  def new
    @question = Question.new #추가된 코드
    @question.question_similar_words.build #추가된 코드
  end

  require 'csv'

  def export_to_csv
    @questions = Question.all  # 데이터를 가져오는 방법
    @question_similar_word = QuestionSimilarWord.all
    
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"questions.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def create
  
      # Strong Parameters를 사용하여 question_params 설정
      question_params = params.require(:question).permit(:question, :description, :tag_id, question_similar_words_attributes: [:id, :similar_word, :_destroy])

      @question = Question.new(question_params)
  
      if @question.save
        # 선택한 태그의 ID를 가져옵니다.
        tag_id = params[:tag_id]
  
        # 선택한 태그와의 관계를 설정합니다.
        if tag_id.present?
          tag = Tag.find_by(id: tag_id)
          @question.tags << tag
        end
  
        redirect_to admins_index_path
      else
        # 실패 처리
      end
    # end
    
  end

  def show
  
  end

  def edit
    @question_tags = @question.tags
  end

  def update

    question_params = params.require(:question).permit(:question, :description, :tag_id, question_similar_words_attributes: [:id, :similar_word, :_destroy])

    if @question.update(question_params)
      # Update the selected tag for the question
      tag_id = params[:tag_id]
      if tag_id.present?
        tag = Tag.find_by(id: tag_id)
        @question.tags = [tag]
      else
        # If no tag is selected, you may want to handle this case accordingly
        @question.tags.clear
      end
  
      redirect_to admins_index_path
    else
      # Handle the case where the update fails
      render :edit
    end

  end

  def destroy
    @question.destroy
    @question_similar_word.destroy
    
    redirect_to admins_index_path
  end
end