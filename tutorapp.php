<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');
//$user = $_SESSION['username'];
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
// $user = $_SESSION['username'];
$tablename = "tutorApp";
//*******change this to only get slots that do not have an assigned student
//(WHERE FK_student = null)
$query = "SELECT FK_hawkID, email, phone FROM $tablename;";
$result = queryDB($query, $db);
$tutorAppArray = array();
$i = 0;
// go through the results one by one
while ($currApp = nextTuple($result)) {
    $tutorAppArray[$i] = $currApp;
    $i++;
}
// put together a JSON object
$response = array();
//$response2 = array();
$response['status'] = 'success';
//$response['value']['user'] = $_Session['username'];
//$response2['status'] = 'success';
$response['value']['tutorApp'] = $tutorAppArray;
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
