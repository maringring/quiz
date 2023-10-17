//비밀번호 일치여부 실시간 확인
function checkPasswordMatch() {
    var password1 = document.getElementsByName("newpassword1")[0].value;
    var password2 = document.getElementsByName("newpassword2")[0].value;
    var messageElement = document.getElementById("passwordMatchMessage");

    if (password1 === password2) {
        messageElement.innerText = "確認";
        messageElement.style.color = "green";
    } else {
        messageElement.innerText = "Passwordが 違います。";
        messageElement.style.color = "red";
    }
}

//비밀번호 변경


// function validateAndSubmit(event) {
//     event.preventDefault(); // 폼 제출 막기

//     var password = document.getElementsByName("password")[0].value; 
//     var hashedPasswordFromDatabase = "<%= @user.password_digest %>";
//     console.log('Password from form:', password);
//     console.log('Hashed password from database:', hashedPasswordFromDatabase);

//     if (password === hashedPasswordFromDatabase){
//         console.log('일치');
//         document.getElementById("passwordChangeForm").submit(); // 폼 제출

//         alert("비밀번호가 변경되었습니다.");
//     } else {
//         console.log('불일치');
//         alert("비밀번호를 확인해주세요.");
//     }
// }