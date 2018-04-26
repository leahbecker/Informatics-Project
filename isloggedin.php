<?php
    // log in user by checking whether the session variable username is set

    
    session_start();
    if (isset($_SESSION['hawkID'])) {
        // if the session variable username is set, then we are logged in
        
        $isloggedin = true;
        $username = $_SESSION['hawkID'];
    } else {
        // if we are not logged in
        $isloggedin = false;
        $id = "not logged in";        
    }

    // send response back
    $response = array();
    $response['status'] = 'success';
    $response['loggedin'] = $isloggedin;
    $response['username'] = $username;
    $response['course'] = $_SESSION['course'];
    header('Content-Type: application/json');
    echo(json_encode($response));    
?>