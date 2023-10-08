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

  def find_user_by_email(email)
    User.find_by(email: email)
  end

  def get_user_name
    email = session[:email] # 세션에 저장된 이메일 가져오기
    user = find_user_by_email(email) # 이메일로 사용자 찾기
  
    if user
      user.name # 사용자가 존재하면 사용자 이름 반환
    else
      "Guest" # 사용자가 없으면 기본값으로 "Guest" 반환
    end
  end

  def find_user_rank(rankings, user_name)
    # user = get_user_name(user)
    # user_name = user.name

    rankings.each_with_index do |ranking, index|
      return index + 1 if ranking.name == user_name
    end
    return nil # 사용자를 찾지 못한 경우
  end

  def ranking
    @user_name = get_user_name # 사용자 이름 가져오기
    # @user_rank = find_user_rank(rankings, user_name) #유저 랭크가져오기

    @correct_answers = params[:correct_answers].to_i
    @incorrect_answers = params[:incorrect_answers].to_i
    @correct_rate = (@correct_answers.to_f / (@correct_answers + @incorrect_answers)) * 100


    # 퀴즈 결과 저장
    save_quiz_result(@user_name, @correct_answers, @incorrect_answers)

    @rankings = Ranking.order(correct_rate: :desc).limit(5)
    
    @user_rank = find_user_rank(@rankings, @user_name)
  end

  def save_quiz_result(name, correct_answers, incorrect_answers)
    # 정답률 계산

    total_answers = correct_answers + incorrect_answers
    correct_rate = (correct_answers.to_f / total_answers) * 100
  
    existing_ranking = Ranking.find_by(name: name)

    if existing_ranking.nil?
      # 해당 이름의 랭킹 데이터가 없으면 새로 생성
      Ranking.create(name: name, correct_answers: correct_answers, incorrect_answers: incorrect_answers, correct_rate: correct_rate)
    else
      # 해당 이름의 랭킹 데이터가 이미 있을 경우 비교 후 업데이트
      if correct_answers > existing_ranking.correct_answers
        existing_ranking.update(correct_answers: correct_answers, incorrect_answers: incorrect_answers, correct_rate: correct_rate)
      end
    end
    # 퀴즈 결과 저장
  #  Ranking.create(name: name, correct_answers: correct_answers, incorrect_answers: incorrect_answers, correct_rate: correct_rate)
  end
  

end