const path = require('path')
require('dotenv').config()
var mysql = require("mysql");

console.log(process.env)

var connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
})

connection.connect((err) => {
    if (err) throw err;
    console.log("Connected to mysql");
})

module.exports = {
    GetConnection: function () { return connection }
}
