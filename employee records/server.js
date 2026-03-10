const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "vtu@24943",
    database: "company_db"
});

db.connect(err => {
    if(err) throw err;
    console.log("MySQL Connected");
});

/* GET EMPLOYEES WITH SORTING + FILTER */
app.get("/employees", (req, res) => {

    const sort = req.query.sort || "name";
    const dept = req.query.department;

    let sql = "SELECT * FROM employees";

    if(dept){
        sql += ` WHERE department='${dept}'`;
    }

    if(sort === "date"){
        sql += " ORDER BY joining_date";
    }else{
        sql += " ORDER BY name";
    }

    db.query(sql, (err, result)=>{
        if(err) throw err;
        res.json(result);
    });

});

/* COUNT PER DEPARTMENT */

app.get("/department-count", (req,res)=>{

    const sql = `
    SELECT department, COUNT(*) as total
    FROM employees
    GROUP BY department
    `;

    db.query(sql,(err,result)=>{
        if(err) throw err;
        res.json(result);
    });

});

app.listen(5000, ()=>{
    console.log("Server running on port 5000");
});