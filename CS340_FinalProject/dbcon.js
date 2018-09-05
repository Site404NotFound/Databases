var mysql = require ('mysql');
var pool = mysql.createPool ({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_stockmah',
  password        : 'PUWho2XNKQB4vQcD',
  database        : 'cs340_stockmah'
});

module.exports.pool = pool;
