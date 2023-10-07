class RankingController < ApplicationController
  # def new
  #   user_answer = params[:answer]  # 사용자가 선택한 답

  #   # 퀴즈 데이터베이스에서 해당 퀴즈의 정답을 가져옴 (예: 퀴즈 ID로)
  #   question = Question.find(params[:question_id])
  #   correct_answer = question.correct_answer

  #  # 사용자의 답과 정답을 비교하여 정답 수와 오답 수를 계산
  #   correct_answers = user_answer == correct_answer ? 1 : 0
  #   incorrect_answers = user_answer == correct_answer ? 0 : 1

  #   render json: {
  #     correct_answers: correct_answers,
  #     incorrect_answers: incorrect_answers
  #   }
  # end

  # def create

  # end

  # def destroy

  # end
  # private

  # def calculate_correct_answers(user_answer)
  #   # 정답 계산 로직
  #   # 여기에서 정답 수를 계산하여 반환
  # end

  # def calculate_incorrect_answers(user_answer)
  #   # 오답 계산 로직
  #   # 여기에서 오답 수를 계산하여 반환
  # end

end
