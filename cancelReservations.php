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
        //$query = "SELECT accountID, hashedpass FROM account WHERE hawkID = '$title';";
        $cancelReservation = "UPDATE tutorSlot SET FK_student = null WHERE slotID = $slotID;";
        //upload the problem
        queryDB($cancelReservation, $db);
        
        $creditsQuery = "SELECT sessionsRemaining FROM account WHERE hawkID = '$student';";
        $result = queryDB($creditsQuery, $db);
        $creditsArray = nextTuple($result);
        $credits = $creditsArray['sessionsRemaining'];
        
        $nowQuery = "SELECT NOW() as now;";
        $result = queryDB($nowQuery, $db);
        $now = nextTuple($result)['now'];
        
        $reservedDateQuery = "SELECT datetime FROM tutorSlot WHERE slotID = $slotID;";
        $result = queryDB($reservedDateQuery, $db);
        $reservedDate = nextTuple($result)['datetime'];
        
        $diffQuery = "SELECT TIMESTAMPDIFF(HOUR, '$now', '$reservedDate') AS difference FROM tutorSlot;";
        $result = queryDB($diffQuery, $db);
        $difference = nextTuple($result)['difference'];
        
        $newCredits = $credits;
        $refund = "You canceled with less than 48 hour notice, you will not be refunded the session credit used for this reservation";
        if($difference >= 48){
            $newCredits = $credits + 1;
            $refund = "You have been refunded 1 session credit";
        }
        
        $updateCredits = "UPDATE account SET sessionsRemaining = $newCredits WHERE hawkID = '$student';";
        queryDB($updateCredits, $db);
        
        
        // send a response back to angular
        $response = array();
        $response['status'] = 'success';
        //$response['student'] = $student;
        $response['slotID'] = $slotID;
        $response['now'] = $now;
        $response['difference'] = $difference;
        $response['reservedDate'] = $reservedDate;
        $response['refundText'] = $refund;
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