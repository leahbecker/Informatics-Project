<?php
    session_start();
    include_once('config.php');
    include_once('dbutils.php');
    
    // get data from form
    $data = json_decode(file_get_contents('php://input'), true);
    //$data = (file_get_contents('php://input'), true);
    $student = $_SESSION['username'];
    $slotID = $data['slotID'];
    
    
   // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);    
    
    // check for required fields
    $isComplete = true;
    $errorMessage = "";
    
    
	
    if ($isComplete) {
        
        $creditsQuery = "SELECT sessionsRemaining FROM account WHERE hawkID = '$student';";
        $result = queryDB($creditsQuery, $db);
        $creditsArray = nextTuple($result);
        $credits = $creditsArray['sessionsRemaining'];
        
        if($credits>=1){
            //add the student to the slot
            $updateReservation = "UPDATE tutorSlot SET FK_student = '$student' WHERE slotID = $slotID;";
            //upload the reservation
            queryDB($updateReservation, $db);
            
            $newCredits = $credits -1;
            $updateCredits = "UPDATE account SET sessionsRemaining = $newCredits WHERE hawkID = '$student';";
            queryDB($updateCredits,$db);
        
        
        
            // send a response back to angular
            $response = array();
            $response['status'] = 'success';
            $response['student'] = $student;
            $response['slotID'] = $slotID;
            header('Content-Type: application/json');
            echo(json_encode($response));
        }
        else{
            $response = array();
            $response['status'] = 'error';
            $response['message'] = 'Insufficient Credits' . $newCredits;
            header('Content-Type: application/json');
            echo(json_encode($response));
        }
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