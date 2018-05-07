<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$course = $_SESSION['course'];

$tablename = "problem";

$query = "SELECT * FROM $tablename;";
$queryCourse = "SELECT * FROM $tablename WHERE FK_courseNum = $course;";

$result = queryDB($queryCourse, $db);


$problems = array();

$i = 0;

// go through the results one by one
while ($currProb = nextTuple($result)) {
    $problems[$i] = $currProb;
    $i++;
}



// put together a JSON object
$response = array();
//$response2 = array();
$response['status'] = 'success';
//$response2['status'] = 'success';
$response['value']['problem'] = $problems;

//$response2['value']['problem'] = $problems2;

header('Content-Type: application/json');
echo(json_encode($response));

?>