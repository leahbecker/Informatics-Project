<?php
    include_once('config.php');
    include_once('dbutils.php');
    
    // get data from form
    $data = json_decode(file_get_contents('php://input'), true);
    $hawkID= $data['hawkID'];
	$firstName = $data['firstName'];
    $lastName = $data['lastName'];
    $password = $data['password'];

   // connect to the database
    $db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);    
    
    // check for required fields
    $isComplete = true;
    $errorMessage = "";
    
 if ($isComplete) {
            if (!isset($hawkID) || (strlen($hawkID) <2)) {
            $isComplete = false;
            $errorMessage .= "Please enter a hawkID with at least two characters. ";
        } else {
            $hawkID = makeStringSafe($db, $hawkID);
        }
        
        if (!isset($firstName) || (strlen($firstName) <2)) {
            $isComplete = false;
            $errorMessage .= "Please enter a first name with at least two characters. ";
        } else {
            $firstName = makeStringSafe($db, $firstName);
        }
        
        if (!isset($lastName) || (strlen($lastName) <2)) {
            $isComplete = false;
            $errorMessage .= "Please enter a last name with at least two characters. ";
        } else {
            $lastName = makeStringSafe($db, $lastName);
        }

        if (!isset($password) || (strlen($password) < 6)) {
              $isComplete = false;
              $errorMessage .= "Please enter a password with at least six characters. ";
          }  

     }  
    
  //check if there's already an account with the same hawkID as the one that's being processed
 if ($isComplete) {
    
    // create a hashed version of the password
    $hashedpass = crypt($password, getSalt());
    
    //set up a query to check if the movie is already in the database
    $query = "SELECT account FROM sql WHERE hawkID='$hawkID' AND firstName='$firstName' AND lastName='$lastName'";
    
    //time to run the query
    $result = queryDB($query, $db);
    
    //check on the number of records returned
    if (nTuples($result) > 0) {
        //if a record is returned, it means the hawkID is already in the database
        $isComplete = false;
        $errorMessage .= "The hawkID $hawkID is already taken by $firstName $lastName. ";
    }
 }  
    
    
    
    if ($isComplete) {
        //$query = "SELECT accountID, hashedpass FROM account WHERE hawkID = '$title';";
        $uploadAccount = "INSERT INTO account (hawkID, firstName, lastName) VALUES ('$hawkID','$firstName',$lastName)";
        //upload the problem
        queryDB($uploadAccount, $db);
        
       $hawkID =mysqli_insert_id($db);
    
    
    //send a response back to angular
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $hawkID;
    header('Content-Type: application/json');
    echo(json_encode($response));

} else {
    //there's been an error. It needs to be reported to the angular controller.

    //one of the things that I want to send back is the data that this php file received
    ob_start();
    var_dump($data);
    $postdump = ob_get_clean();
    
    
    //set up response array
    $response = array();
    $response['status'] = 'error';
    $response['message'] = $errorMessage . $postdump;
    header('Content-Type: application/json');
    echo(json_encode($response));

}

?>
