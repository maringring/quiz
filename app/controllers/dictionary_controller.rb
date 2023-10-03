require 'json'

class DictionaryController < ApplicationController
  def new
    
    # 랜덤한 퀴즈를 선택
    @question = Question.order("RANDOM()").first
    @different_question1 = Question.where.not(id: @question.id).order("RANDOM()").first
    @different_question2 = Question.where.not(id: @question.id).order("RANDOM()").second
    @question_similar_word = QuestinSimilarWord.find_by(question_id: @question.id)

    #answer
    @question_description0 = @question.description
    @question_description1 = @different_question1.description
    @question_description2 = @different_question2.description
    
  end

  def next_question
    question = Question.order("RANDOM()").first
    similar_word = QuestinSimilarWord.find_by(question_id: question.id)

    different_question = Question.where.not(id: question.id).order("RANDOM()").first
    different_question2 = Question.where.not(id: question.id).order("RANDOM()").second

    render json: { 
      question: question, similar_word: similar_word, different_question: different_question, different_question2: different_question2
    }
  end

end
