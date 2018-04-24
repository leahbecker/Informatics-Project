<?php
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tablename = "problem";

$query = "SELECT * FROM $tablename;";
$query1020 = "SELECT * FROM $tablename WHERE FK_courseNum = 1020;";
$query1110 = "SELECT * FROM $tablename WHERE FK_courseNum = 1110;";
$query1210 = "SELECT * FROM $tablename WHERE FK_courseNum = 1210;";

$result = queryDB($query, $db);
$result1020 = queryDB($query1020, $db);
$result1110 = queryDB($query1110, $db);
$result1210 = queryDB($query1210, $db);

$problems = array();

$problems1020 = array();
$problems1110 = array();
$problems1210 = array();
$i = 0;

// go through the results one by one
while ($currProb = nextTuple($result)) {
    $problems[$i] = $currProb;
    $i++;
}
$i = 0;
// go through the results one by one
while ($currProb = nextTuple($result1020)) {
    $problems1020[$i] = $currProb;
    $i++;
}
$i = 0;
// go through the results one by one
while ($currProb = nextTuple($result1110)) {
    $problems1110[$i] = $currProb;
    $i++;
}
$i = 0;
// go through the results one by one
while ($currProb = nextTuple($result1210)) {
    $problems1210[$i] = $currProb;
    $i++;
}

// put together a JSON object
$response = array();
//$response2 = array();
$response['status'] = 'success';
//$response2['status'] = 'success';
$response['value']['problem'] = $problems;
$response['value']['problem1020'] = $problems1020;
$response['value']['problem1110'] = $problems1110;
$response['value']['problem1210'] = $problems1210;
//$response2['value']['problem'] = $problems2;

header('Content-Type: application/json');
echo(json_encode($response));
//echo(json_encode($response2));
/* 
    include_once('config.php');
    include_once('dbutils.php');
    
    //connect
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
    
    
    $tablename = "movies";
    //query
    $query = "SELECT * FROM $tablename;";
    
    $result = queryDB($query, $db);
    
    //results to array
    $moviesArray = array();
    $i = 0;
    
    while($currMovie = nextTuple($result)){
        $moviesArray[$i] = $currMovie;
        $i++;
    }
    
    //JSON object
    $response = array();
    $response['status'] = 'success';
    
    $response['value']['movies'] = $moviesArray;
    header('Content-Type: application/json');
    echo(json_encode($response));
*/
?>