const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(cors());

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "vtu@24943",
    database: "order_management"
});

db.connect(err => {
    if (err) throw err;
    console.log("Database connected");
});

app.get("/orders", (req,res)=>{
    const sql = `
    SELECT customers.name,
    products.product_name,
    orders.quantity,
    products.price,
    (orders.quantity * products.price) AS total_price,
    orders.order_date
    FROM orders
    JOIN customers ON orders.customer_id = customers.customer_id
    JOIN products ON orders.product_id = products.product_id
    ORDER BY orders.order_date DESC
    `;

    db.query(sql,(err,result)=>{
        if(err) throw err;
        res.json(result);
    });
});

app.listen(5000,()=>{
    console.log("Server running on port 5000");
});