
(function () {
    'use strict';
    
    var myApp = angular.module("app");
    
    myApp.controller("dataControl", function($scope, $http, $window) {
        
        
        // function to send new account information to web api to add it to the database
        $scope.newAccount = function(accountDetails) {
          var accountupload = angular.copy(accountDetails);
          
          $http.post("newaccount.php", accountupload)
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // send user back to home page
                        $window.location.href = "index.html";
                    }
               } else {
                    alert('unexpected error');
               }
            });                        
        };        
        
        // function to send new account information to web api to add it to the database
        $scope.login = function(accountDetails) {
          var accountupload = angular.copy(accountDetails);
          
          $http.post("login.php", accountupload)
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    }
                    else if(response.data.role == 'student'){
                        alert('student');
                        $window.location.href = "index.html";
                    }
                    else if(response.data.role == 'tutor'){
                        alert('tutor');
                        $window.location.href = "tutorhome.html";
                    }
                    else if(response.data.role == 'faculty'){
                        alert('faculty');
                        $window.location.href = "facultyhome.html";
                    }
                    else {
                        // successful
                        // send user back to home page
                        alert('no role');
                        //$window.location.href = "facultyhome.html";
                    }
               } else {
                    alert('unexpected error');
               }
            });                        
        };
        
        $scope.adminlogin = function(accountDetails) {
          var accountupload = angular.copy(accountDetails);
          
          $http.post("login.php", accountupload)
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    }
                    else if(response.data.admin == '1') {
                        // successful
                        // send user back to home page
                        alert('admin!');
                        $window.location.href = "adminhome.html";
                    }
                    else{alert(response.data.admin);}
               } else {
                    alert('unexpected error');
               }
            });                        
        };
        
        // function to log the user out
        $scope.logout = function() {
          $http.post("logout.php")
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        $window.location.href = "login.html";
                    }
               } else {
                    alert('unexpected error');
               }
            });                        
        };             
        
        // function to check if user is logged in
        $scope.checkifloggedin = function() {
          $http.post("isloggedin.php")
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // set $scope.isloggedin based on whether the user is logged in or not
                        $scope.isloggedin = response.data.loggedin;
                    }
               } else {
                    alert('unexpected error');
               }
            });                        
        };       

    });
    
} )();
