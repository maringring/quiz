class AdminsController < ApplicationController
  def index
    @questions = Question.all
    @question_similar_word = QuestinSimilarWord.all
  end

  def new
  end

  def create
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
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question: params[:question_question], description: params[:question_description])
    
    @question_similar_word = QuestinSimilarWord.find(params[:id])
    @question_similar_word.update(similar_word: params[:QuestinSimilarWord_similar_word])

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
