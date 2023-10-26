class AdminsController < ApplicationController
  def index
    @questions = Question.all
    @question_similar_word = QuestinSimilarWord.all
    @tags = Tag.all
    @question_tags = @questions.map { |q| q.tags }
  end

  def new
    @tags = Tag.all
  end

  require 'csv'

  def export_to_csv
    @questions = Question.all  # 데이터를 가져오는 방법은 실제 애플리케이션에 따라 다를 수 있습니다.
    @question_similar_word = QuestinSimilarWord.all
    
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"questions.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def create
    @tags = Tag.all

    if params[:question_question].blank? || params[:question_description].blank? || params[:QuestinSimilarWord_similar_word].blank?
      flash[:alert] = "Question, Description, Similar Word를 모두 입력해주세요."

      # 세션에 값을 저장
      session[:question_question] = params[:question_question]
      session[:question_description] = params[:question_description]
      session[:QuestinSimilarWord_similar_word] = params[:QuestinSimilarWord_similar_word]

      redirect_to admins_new_path
    else
      @questions = Question.create(question: params[:question_question], description: params[:question_description])
      @question_similar_word = QuestinSimilarWord.create(similar_word: params[:QuestinSimilarWord_similar_word])
      @question_similar_word.update(question_id: @question_similar_word.id)

      # 선택한 태그의 ID를 가져옵니다.
      tag_id = params[:tag_id]

      # 선택한 태그와의 관계를 설정합니다.
      if tag_id.present?
        tag = Tag.find_by(id: tag_id)
        @questions.tags << tag
      end

      # 세션 값을 지움
      session.delete(:question_question)
      session.delete(:question_description)
      session.delete(:QuestinSimilarWord_similar_word)
    
    redirect_to admins_index_path
    end
  end

  def show
    @question = Question.find(params[:id])
    @question_similar_word = QuestinSimilarWord.find(params[:id])
  end

  def edit
   
    @question = Question.find(params[:id])
    @question_similar_word = QuestinSimilarWord.find(params[:id])

    @tags = Tag.all
    @question_tags = @question.tags

  end

  def update
    
    @question = Question.find(params[:id])
    @question.update(question: params[:question_question], description: params[:question_description])
    
    @question_similar_word = QuestinSimilarWord.find(params[:id])
    @question_similar_word.update(similar_word: params[:QuestinSimilarWord_similar_word])


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
    @question_similar_word = QuestinSimilarWord.find(params[:id])
    @question_similar_word.destroy
    
    redirect_to admins_index_path
  end
end
