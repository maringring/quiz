
//퀴즈 중복출제방지
let previousChoices = [];  // 이전에 선택한 선택지 저장

  //답 중복 방지
  function getRandomNonRepeatingChoices(choices, count) {
    const nonRepeatingChoices = [];
    const usedIndices = [];
  
    // 중복되지 않는 랜덤 인덱스 생성
    while (nonRepeatingChoices.length < count) {
      const randomIndex = Math.floor(Math.random() * choices.length);
  
      if (!usedIndices.includes(randomIndex)) {
        nonRepeatingChoices.push(choices[randomIndex]);
        usedIndices.push(randomIndex);
      }
    }
  
    return nonRepeatingChoices;
  }

 
  let askedQuestions = [];

function displayQuestion(question, similarWord, _differentQuestion, _differentQuestion2) {

 
  if (!askedQuestions.includes(question.id)) {
    askedQuestions.push(question.id); //이미 나온 문제

    qid =question.id;
    $('#question_content').text(question.question);
    $('#similar_word').text(similarWord.similar_word);
  
    
    // 라디오문제값 랜덤선택
    const choices = [
      { id: question.id, description: question.description },
      { id: _differentQuestion.id, description: _differentQuestion.description },
      { id: _differentQuestion2.id, description: _differentQuestion2.description }
    ];

    
    // 3개의 중복되지 않는 선택지 가져오기
    const nonRepeatingChoices = getRandomNonRepeatingChoices(choices, 3);
    
    // 각 라디오 버튼에 선택지 할당
    $('#flexRadioDefault1').next().text(nonRepeatingChoices[0].description);
    $('#flexRadioDefault2').next().text(nonRepeatingChoices[1].description);
    $('#flexRadioDefault3').next().text(nonRepeatingChoices[2].description);
    
    // 각 라디오 버튼에 선택지에 대응하는 id를 value로 설정
    $('#flexRadioDefault1').val(nonRepeatingChoices[0].id);
    $('#flexRadioDefault2').val(nonRepeatingChoices[1].id);
    $('#flexRadioDefault3').val(nonRepeatingChoices[2].id);

    previousChoices = [];
  }else{
    console.log("중복");
  }
  
    
}

$(document).ready(function() {
  // 문제번호 인덱스
  let correctAnswers = 0; // 정답 수
  let incorrectAnswers = 0; // 오답 수
  let questionNumber = 1;
  let selectedId;

  loadNextQuestion();  // 페이지 로드 시 첫 번째 질문 로드


  // function updateQuestionNumber() {
  //   $('#question_number').text(questionNumber);
  // }

    //퀴즈데이터
  function loadNextQuestion() {
    $.ajax({
      url: '/dictionary/next_question',
      method: 'GET',
      success: function(response) {
        console.log(askedQuestions);
        if (askedQuestions.includes(response.question.id)) {
          // If asked before, load the next question
          loadNextQuestion();
        } else {
          // If not asked before, display the question
          $('#question_number').text(questionNumber); //리로드시 문제번호 호출
          displayQuestion(response.question, response.similar_word, response.different_question, response.different_question2);
        }
      },
      error: function(error) {
        console.error('Failed to load next question:', error);
      }
    });
  }

  $('form').submit(function(event) {

    const selectedId = $('input[name="flexRadioDefault"]:checked').val();
    const numericValue = parseInt(selectedId);
    console.log('선택된 ID:', selectedId);

    console.log('Numeric value:', numericValue);
    console.log('questionid',qid);

    if (numericValue == qid) {
      correctAnswers++;
    } else {
      incorrectAnswers++;
    }


    event.preventDefault(); //폼 제출 방지
    questionNumber++;  // 인덱스번호 증가

    if (questionNumber > 10) { // 문제수 도달시 페이지 이동
      window.location.href = '/dictionary/ranking?correct_answers=' + correctAnswers + '&incorrect_answers=' + incorrectAnswers;
    }else{
       loadNextQuestion();  // 양식 제출 시 다음 질문 로드
    }

    //라디오버튼 리셋
    $('input[name="flexRadioDefault"]').prop('checked', false);

  });

});
