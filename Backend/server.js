const express = require("express");
const parser = require("body-parser");
const createCsvWriter = require('csv-writer').createObjectCsvWriter;
const app = express();
app.use(parser.urlencoded({extended:true , limit:"50mb"}));
const logWriter = createCsvWriter({
    path: 'logs.csv',
    header: [
        {id: 'timeStamp', title: 'TIMESTAMP'},
        {id: 'action', title: 'ACTION'},
        {id: 'userID', title: 'USER ID'},
        {id: 'info', title: 'Extra info string'},
    ]
});
const obsWriter = createCsvWriter({
    path: 'observations.csv',
    header: [
        {id: 'userID', title: 'USER ID'},
        {id: 'time', title: 'TIME'},
        {id: 'quadrant', title: 'QUADRANT'},
        {id: 'octant', title: 'OCTANT'},
        {id: 'buildingBlock', title: 'BUIDLINGBLOCK'},
        {id: 'teamScore', title: 'TEAM'},
        {id: 'opponentScore', title: 'OPPONENT'},
        {id: 'timing', title: 'TIMING'},
        {id: 'audience', title: 'AUDIENCE'},
        {id: 'corType', title: 'CORRECTION TYPE'},
    ]
});


app.listen(3980,async function(){
  console.log("sever started!");
});
app.get("/", function(req,res){
  res.send("check!");
  console.log('getCheck recieved');
});

app.post("/logs", async function(req,res){
  console.log("een post Log request ontvangen!");
  var logs = JSON.parse(req.body.logs);
  var obs = JSON.parse(req.body.observations);
  console.log(obs);
  putLogsInCSVFile(logs);
  putObsInCSVFile(obs);
  res.status(200).send('Logs toegevoegd!');
  //console.log(logs);



});

function putObsInCSVFile(observations){
  obsWriter.writeRecords(observations)       // returns a promise
    .then(() => {
        console.log('obs geschreven in de CSV');
    });
}

function putLogsInCSVFile(logs){
  logWriter.writeRecords(logs)       // returns a promise
    .then(() => {
        console.log('Logs geschreven in de CSV');
    });
}

// app.post("/logs", async function(req,res){
//
//       console.log("een post request ontvangen!");
//       var projectNr = req.body.ProjectNr;
//       var gemeente = req.body.Gemeente;
//       var projectUitleg = req.body.ProjectUitleg;
//       var straat = req.body.Straat;
//       var aansluitingsNr = req.body.AansluitingNr;
//       var dataRWA = JSON.parse(req.body.RWA);
//       var dataDWA = JSON.parse(req.body.DWA);
//       var base64Images = JSON.parse(req.body.Images);
//
//
//
// });
