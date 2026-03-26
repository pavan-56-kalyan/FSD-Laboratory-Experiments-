const form = document.getElementById("loginForm");

form.addEventListener("submit", async function(e){

e.preventDefault();

const email = document.getElementById("email").value;
const password = document.getElementById("password").value;
const error = document.getElementById("error");

if(email === "" || password === ""){
error.innerText = "Please fill all fields";
return;
}

const res = await fetch("http://localhost:5000/login",{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({email,password})
});

const data = await res.json();

if(data.success){
alert("Login Successful");
}
else{
error.innerText = "Invalid email or password";
}

});