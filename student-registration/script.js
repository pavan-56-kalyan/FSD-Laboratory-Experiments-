const form = document.getElementById("studentForm");

form.addEventListener("submit", async function(e){
e.preventDefault();

const data = {
name: document.getElementById("name").value,
email: document.getElementById("email").value,
dob: document.getElementById("dob").value,
department: document.getElementById("department").value,
phone: document.getElementById("phone").value
};

await fetch("http://localhost:5000/register",{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify(data)
});

alert("Student Registered");
form.reset();
});

async function loadStudents(){

const res = await fetch("http://localhost:5000/students");
const students = await res.json();

const tbody = document.querySelector("#studentTable tbody");
tbody.innerHTML="";

students.forEach(s => {
tbody.innerHTML += `
<tr>
<td>${s.name}</td>
<td>${s.email}</td>
<td>${s.dob}</td>
<td>${s.department}</td>
<td>${s.phone}</td>
</tr>
`;
});

}