const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
host:"localhost",
user:"root",
password:"vtu@24943",
database:"login_db"
});

db.connect(err=>{
if(err){
console.log("Database Error");
}
else{
console.log("Connected to MySQL");
}
});

app.post("/login",(req,res)=>{

const {email,password} = req.body;

const sql = "SELECT * FROM users WHERE email=? AND password=?";

db.query(sql,[email,password],(err,result)=>{

if(err) throw err;

if(result.length > 0){
res.json({success:true});
}
else{
res.json({success:false});
}

});

});

app.listen(5000,()=>{
console.log("Server running on port 5000");
});