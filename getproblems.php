<?php
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tablename = "problem";

$query = "SELECT * FROM $tablename;";
$result = queryDB($query, $db);

$problems = array();
$i = 0;

// go through the results one by one
while ($currProb = nextTuple($result)) {
    $problems[$i] = $currProb;
    $i++;
}

// put together a JSON object
$response = array();
$response['status'] = 'success';

$response['value']['problem'] = $problems;
header('Content-Type: application/json');
echo(json_encode($response));
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