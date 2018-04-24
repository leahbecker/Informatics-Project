<?php
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

$user = $_SESSION['username'];
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tablename = "tutorSlot";
//*******change this to only get slots that do not have an assigned student
//(WHERE FK_student = null)
$query = "SELECT slotID, FK_student, FK_tutor, courseName.courseName, datetime FROM $tablename,courseName
WHERE courseName.courseNum =
(SELECT FK_courseNum FROM course WHERE courseID = FK_courseID);";

$querySlotsTakenByUser = "SELECT slotID, FK_student, FK_tutor, courseName.courseName, datetime FROM $tablename,courseName
WHERE courseName.courseNum =
(SELECT FK_courseNum FROM course WHERE courseID = FK_courseID) AND FK_student = '$user';";

$result = queryDB($query, $db);
$resultT = queryDB($querySlotsTakenByUser, $db);

$slots = array();
$i = 0;

// go through the results one by one
while ($currSlot = nextTuple($result)) {
    $slots[$i] = $currSlot;
    $i++;
}

$slots2 = array();
$i = 0;

// go through the results one by one
while ($currSlot = nextTuple($result)) {
    $slotsTakenByUser[$i] = $currSlot;
    $i++;
}

// put together a JSON object
$response = array();
//$response2 = array();
$response['status'] = 'success';
//$response['value']['user'] = $_Session['username'];
//$response2['status'] = 'success';
$response['value']['slot'] = $slots;
//$response['value']['user'] = $user;
$response['value']['slotsTakenByUser'] = $slotsTakenByUser;
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