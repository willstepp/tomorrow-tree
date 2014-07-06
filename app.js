var express = require('express');
var http = require('http');

app = express();
app.set('port', process.env.PORT || 3001);

app.get('/', function(req, res){
  res.send('<h3>The Tomorrow Tree</h3>');
});

//server
http.createServer(app).listen(app.get('port'), function(){
  console.log('Tomorrow Tree listening on port ' + app.get('port'));
});