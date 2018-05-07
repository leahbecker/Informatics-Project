<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

//$user = $_SESSION['username'];
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
$user = $_SESSION['username'];
$tablename = "tutorSlot";
//*******change this to only get slots that do not have an assigned student
//(WHERE FK_student = null)
$queryAvailableSlots = "SELECT slotID, FK_student, FK_tutor, courseName.courseName, datetime FROM $tablename,courseName
WHERE FK_student is null
AND courseName.courseNum =
(SELECT FK_courseNum FROM course WHERE courseID = FK_courseID)
AND tutorSlot.dateTime >= NOW();";

$querySlotsTakenByUser = "SELECT slotID, FK_student, FK_tutor, courseName.courseName, datetime FROM $tablename,courseName
WHERE FK_student = '$user'
AND courseName.courseNum =
(SELECT course.FK_courseNum FROM course WHERE course.courseID = tutorSlot.FK_courseID)
AND tutorSlot.dateTime >= NOW();";

$result = queryDB($queryAvailableSlots, $db);
$resultT = queryDB($querySlotsTakenByUser, $db);

$availableSlots = array();
$i = 0;

// go through the results one by one
while ($currSlot = nextTuple($result)) {
    $availableSlots[$i] = $currSlot;
    $i++;
}

$slotsTakenByUser = array();
$i = 0;

// go through the results one by one
while ($currSlot = nextTuple($resultT)) {
    $slotsTakenByUser[$i] = $currSlot;
    $i++;
}

// put together a JSON object
$response = array();
//$response2 = array();
$response['status'] = 'success';
//$response['value']['user'] = $_Session['username'];
//$response2['status'] = 'success';
$response['value']['availableSlots'] = $availableSlots;
//$response['value']['user'] = $user;
$response['value']['slotsTakenByUser'] = $slotsTakenByUser;
//$response2['value']['problem'] = $problems2;

header('Content-Type: application/json');
echo(json_encode($response));

?>