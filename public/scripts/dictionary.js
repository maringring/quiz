function loadNextQuestion() {
    $.ajax({
      url: '/dictionary/next_question',
      method: 'GET',
      success: function(response) {
        displayQuestion(response.question, response.similar_word, response.different_question, response.different_question2);
      },
      error: function(error) {
        console.error('Failed to load next question:', error);
      }
    });
  }

  let previousChoices = [];  // 이전에 선택한 선택지 저장

    function getRandomChoice(choices) {
    // 이전에 선택한 선택지와 겹치지 않는 선택지를 찾을 때까지 반복
    let randomChoice;
    do {
        randomChoice = choices[Math.floor(Math.random() * choices.length)];
    } while (previousChoices.includes(randomChoice));
    
    // 선택한 선택지를 이전 선택지 목록에 추가하고 반환
    previousChoices.push(randomChoice);
    return randomChoice;
    }
  
  function displayQuestion(question, similarWord, _differentQuestion, _differentQuestion2) {
    $('#question_content').text(question.question);
    $('#similar_word').text(similarWord.similar_word);
  
    // Set choices based on question and similar word
    const choices = [question.description, _differentQuestion.description, _differentQuestion2.description];
    $('#flexRadioDefault1').next().text(getRandomChoice(choices));
    $('#flexRadioDefault2').next().text(getRandomChoice(choices));
    $('#flexRadioDefault3').next().text(getRandomChoice(choices));

    previousChoices = [];

    // Set other choices with some logic based on your requirements
    // ...
  
    // Set hidden input with question ID for submission
    $('#question_id').val(question.id);
  }
  
  $(document).ready(function() {
    loadNextQuestion();  // Load the first question on page load
  
    $('form').submit(function(event) {
      event.preventDefault();
      loadNextQuestion();  // Load the next question on form submission
    });
  });
  