<?php
    include_once('config.php');
    include_once('dbutils.php');
    
    // get data from form
    $data = json_decode(file_get_contents('php://input'), true);
    $title= $data['title'];
	$problem = $data['problemtext'];
    $course = $data['course'];
    if ($course == "CS: 1020"){
        $course = 1020;
    }
    else if($course == "CS: 1110"){
        $course = 1110;
    }
    else if($course == "CS: 1210"){
        $course = 1210;
    }
    else{
        $course="null";
    }
   // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);    
    
    // check for required fields
    $isComplete = true;
    $errorMessage = "";
    
    
	
    if ($isComplete) {
        //$query = "SELECT accountID, hashedpass FROM account WHERE hawkID = '$title';";
        $uploadProblem = "INSERT INTO problem (title, text, FK_courseNum) VALUES ('$title','$problem',$course)";
        //upload the problem
        queryDB($uploadProblem, $db);
        
        
        // send a response back to angular
    $response = array();
    $response['status'] = 'success';
    header('Content-Type: application/json');
    echo(json_encode($response));    
} else {
    // there's been an error. We need to report it to the angular controller.
    
    // one of the things we want to send back is the data that his php file received
    ob_start();
    var_dump($data);
    $postdump = ob_get_clean();
    
    // set up our response array
    $response = array();
    $response['status'] = 'error';
    $response['message'] = $errorMessage . $postdump;
    header('Content-Type: application/json');
    echo(json_encode($response));    
}

?>