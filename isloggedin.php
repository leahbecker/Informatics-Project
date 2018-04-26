<?php
    // log in user by checking whether the session variable username is set

    
    session_start();
    if (isset($_SESSION['username'])) {
        // if the session variable username is set, then we are logged in
        
        $isloggedin = true;
        $username = $_SESSION['username'];
    } else {
        // if we are not logged in
        $isloggedin = false;
        $id = "not logged in";        
    }

    // send response back
    $response = array();
    $response['status'] = 'success';
    $response['loggedin'] = $isloggedin;
    $response['username'] = $id;
    $response['course'] = $_SESSION['course'];
    header('Content-Type: application/json');
    echo(json_encode($response));    
?>