const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: "localhost",
    user: "nodeuser",
    password: "1234",
    database: "student_db"
});


db.connect(err=>{
if(err) throw err;
console.log("MySQL Connected");
});

app.post("/register",(req,res)=>{

const {name,email,dob,department,phone} = req.body;

const sql = "INSERT INTO students (name,email,dob,department,phone) VALUES (?,?,?,?,?)";

db.query(sql,[name,email,dob,department,phone],(err,result)=>{
if(err) throw err;
res.send("Student Registered");
});

});

app.get("/students",(req,res)=>{

const sql = "SELECT * FROM students";

db.query(sql,(err,result)=>{
if(err) throw err;
res.json(result);
});

});

app.listen(5000,()=>{
console.log("Server running on port 5000");
});