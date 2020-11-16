const password = document.getElementById('password');

document.getElementById('login').addEventListener('click', (e) => {
    removeErrorFor();

    if (password.value.trim().length < 8) {
        setErrorFor(password, "Password must 8 character");
    }
})

const setErrorFor = (input, messager) => {
    let p = document.createElement("p");
    p.className = 'error';
    p.innerHTML = messager;
    p.style.color = "red";
    input.parentElement.appendChild(p);
}

const removeErrorFor = () => {
    let errorArray = document.querySelectorAll(".error");
   if (errorArray.length != 0) {

        for (var i = 0; i < errorArray.length; i++) {
            console.log(errorArray[i].className + ":" + i);
            errorArray[i].remove();
         }
    }
     
}