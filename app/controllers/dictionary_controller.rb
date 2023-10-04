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

    questions_count = Question.count
    # 중복된 문제를 방지하기 위해 이미 출제한 문제의 ID 리스트
    answered_question_ids = session[:answered_question_ids] || []

    # 중복되지 않는 랜덤 문제를 선택
    question = nil
    loop do
      question = Question.offset(rand(questions_count)).first
      break unless answered_question_ids.include?(question.id)
    end

    # 선택된 문제의 ID를 기록
    answered_question_ids << question.id
    session[:answered_question_ids] = answered_question_ids

    # question = Question.order("RANDOM()").first
    similar_word = QuestinSimilarWord.find_by(question_id: question.id)

    different_question = Question.where.not(id: question.id).order("RANDOM()").first
    different_question2 = Question.where.not(id: question.id).order("RANDOM()").second

    render json: { 
      question: question, similar_word: similar_word, different_question: different_question, different_question2: different_question2
    }
  end

end
