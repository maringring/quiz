class AdminsController < ApplicationController
  def index
    #@admins = Admin.all
    @questions = Question.all
    @question_similar_word = QuestinSimilarWord.all
  end

  def new
  end

  def create
    @questions = Question.create(question: params[:question_question], description: params[:question_description])
    # @admin = Admin.create(question: params[:admin_question], description: params[:admin_description])
    @question_similar_word = QuestinSimilarWord.create(similar_word: params[:QuestinSimilarWord_similar_word])
    @question_similar_word.update(question_id: @question_similar_word.id)
    
    redirect_to admins_index_path
    
  end

  def show
    @question = Question.find(params[:id])
    # @admin = Admin.find(params[:id])
    @question_similar_word = QuestinSimilarWord.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
    # @admin = Admin.find(params[:id])
    @question_similar_word = QuestinSimilarWord.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question: params[:question_question], description: params[:question_description])
    # @admin = Admin.find(params[:id])
    # @admin.update(question: params[:admin_question],description: params[:admin_description])
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
