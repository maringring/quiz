class AdminsController < ApplicationController
  def index
    @questions = Question.all
    @question_similar_word = QuestionSimilarWord.all
    @tags = Tag.all
    @question_tags = @questions.map { |q| q.tags }
  end

  def new
    @tags = Tag.all
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
    @tags = Tag.all
  
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
    @question = Question.find(params[:id])
    # @question_similar_word = QuestionSimilarWord.find(params[:id])
    @question_similar_word = @question.question_similar_words
  end

  def edit
   
    @question = Question.find(params[:id])
    # @question_similar_word = QuestionSimilarWord.find(params[:id])
    @question_similar_word = @question.question_similar_words

    @tags = Tag.all
    @question_tags = @question.tags

  end

  def update
    
    @question = Question.find(params[:id])
    @question.update(question: params[:question_question], description: params[:question_description])
    
    @question_similar_word = QuestionSimilarWord.find(params[:id])
    @question_similar_word.update(similar_word: params[:QuestionSimilarWord_similar_word])


    # 선택한 태그의 ID를 가져옵니다.
    tag_id = params[:tag_id]

    # 기존 태그 관계 삭제
    @question.tags.destroy_all

    # 선택한 태그와의 관계를 설정합니다.
    if tag_id.present?
      tag = Tag.find_by(id: tag_id)
      @question.tags << tag
    end

    redirect_to admins_index_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    # @admin = Admin.find(params[:id])
    # @admin.destroy
    # @question_similar_word = QuestinSimilarWord.find(params[:id])
    @question_similar_word = @question.question_similar_words
    @question_similar_word.destroy
    
    redirect_to admins_index_path
  end
end