<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

$data = json_decode(file_get_contents('php://input'), true);
$slotID = $data['slotID'];
$answerText = $data['answerTextEntry'];
$student = $_SESSION['username'];

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tablename = "answersProblem";

$existsQuery = "SELECT * FROM $tablename WHERE slotID = $slotID AND FK_hawkID ='$student';";
$result = queryDB($existsQuery, $db);
if(!empty($result)){
    $updateAnswer = "UPDATE $tablename SET answerText = '$answerText' WHERE slotID ='$slotID';";
    queryDB($updateAnswer,$db);
    
} else{
    $insertAnswer = "INSERT INTO $tablename (FK_slotID,FK_hawkID,answerText) VALUES ($slotID,'$student','$answerText');";
    queryDB($insertAnswer,$db);
}

$getAnswersQuery = "SELECT * FROM answersProblem WHERE FK_hawkID = '$student';";
$getAnswers = queryDB($getAnswersQuery,$db);

// go through the results one by one
$answers = array();
$i = 0;
while ($currAns = nextTuple($getAnswers)) {
    $answers[$i] = $currAns;
    $i++;
}


// put together a JSON object
$response = array();
//$response2 = array();
$response['status'] = 'success';
//$response2['status'] = 'success';
$response['value']['answers'] = $answers;


header('Content-Type: application/json');
echo(json_encode($response));

?>