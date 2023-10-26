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
