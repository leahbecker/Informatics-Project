<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');
//$user = $_SESSION['username'];
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
// $user = $_SESSION['username'];
$tablename = "weeklySlot";
//*******change this to only get slots that do not have an assigned student
//(WHERE FK_student = null)
$query = "SELECT hawkID, weekday, startTime, endTime FROM $tablename;";

$result = queryDB($query, $db);

$weeklySlotArray = array();
$i = 0;

// go through the results one by one
while ($currSlot = nextTuple($result)) {
    $weeklySlotArray[$i] = $currSlot;
    $i++;
}

// put together a JSON object
$response = array();
//$response2 = array();
$response['status'] = 'success';
//$response['value']['user'] = $_Session['username'];
//$response2['status'] = 'success';
$response['value']['weeklySlot'] = $weeklySlotArray;
//$response['value']['user'] = $user;
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
