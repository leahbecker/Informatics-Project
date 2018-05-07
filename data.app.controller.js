(function () {
    'use strict';
    
    var myApp = angular.module("app");
    
    myApp.controller("dataControl", function($scope, $http, $window) {
    
        //$scope.time = [];
        
        $http.get('getproblems.php')
            .then(function(response) {
                $scope.data = response.data.value;
            }
            );
            
        $http.get('getStudentAnswers.php')
            .then(function(response) {
                $scope.studentAnswers = response.data.value;
            }
            );
            
        
        $http.get('getSlots.php')
            .then(function(response) {
                $scope.slots = response.data.value;
            }
            );
            
        $http.get('weeklySlots.php')
            .then(function(response) {
                $scope.weeklySlot = response.data.value;
            }
            );
            
            $http.get('editavailability.php')
            .then(function(response) {
                $scope.editSlots = response.data.value;
            }
            );
            
            
            $http.get('tutorapp.php')
            .then(function(response) {
                $scope.tutorApp = response.data.value;
            }
            );
        
             $http.get('sessionsremaining.php')
            .then(function(response) {
                $scope.sessions = response.data.sessions;
            }
            );
            
            $http.get('isloggedin.php')
            .then(function(response){
                $scope.role = response.data.role;
            });
        
        $scope.query = {};
        $scope.queryBy = "$";
        
        // function to send new account information to web api to add it to the database
-        $scope.createaccount = function(acctDetails) {
-          var acctUpload = angular.copy(acctDetails);
-          
-          $http.post("createaccount.php", acctUpload)
-            .then(function (response) {
-               if (response.status == 200) {
-                    if (response.data.status == 'error') {
-                        alert('error: ' + response.data.message);
-                    } else {
-                        // successful
-                       alert('Account successfully added.');
-                    }
-               } else {
-                    alert('unexpected error');
-               }
-            });                        
-        };
-        
-        
-        
-        /*
-        
         // function to send new account information to web api to add it to the database
         $scope.newAccount = function(accountDetails) {
           var accountupload = angular.copy(accountDetails);
@@ -95,9 +78,6 @@
                }
             });                        
         };
-        */
        
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
        
        $scope.uploadproblem = function(accountDetails) {
          var accountupload = angular.copy(accountDetails);
          
          $http.post("uploadproblem.php", accountupload)
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // send user back to home page
                        $window.location.href = "facultyhome.html";
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
                        //alert('student');
                       
                        $window.location.href = "index.html";
                    }
                    else if(response.data.role == 'tutor'){
                        //alert('tutor');
                        
                        $window.location.href = "tutorhome.html";
                    }
                    else if(response.data.role == 'faculty'){
                        //alert('faculty');
                        
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
        
         //used by the home button, brings user to the correct home page for their role
        $scope.goHome = function(role){
            if(role == 'tutor'){
                $window.location.href = "tutorhome.html";
            }
            else if(role == 'faculty'){
                $window.location.href = "facultyhome.html";
            }
            else if(role == 'student'){
                $window.location.href = "index.html";
            }
            else{
                alert(role);
            }
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
                        //alert('admin!');
                        $window.location.href = "adminhome.html";
                    }
                    else{alert('You are not an admin');}
               } else {
                    alert('unexpected error');
               }
            });                        
        };
        
        $scope.reserve = function(slot) {
        //var slotUpload = angular.copy(slot);
          if(confirm('Are you sure you want to reserve this slot? 1 session credit will be deducted from your account if you proceed.')){
          $http.post("reservations.php", slot)
            .then(function (response) {
                
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    }
                 else  {
                    alert('Reserved!');
                    location.reload();
               }
               } else{
                alert('unexpected error');
               }
            });                        
          }};
        
        $scope.cancel = function(slot) {
        //var slotUpload = angular.copy(slot);
          if(confirm('Are you sure you want to cancel? Session credits will only be refunded if cancelation is made 48+ hours in advance')){
          $http.post("cancelReservations.php", slot)
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    }
                 else  {
                    alert('Canceled ' + response.data.refundText);
                    location.reload();
               }
               } else{
                alert('unexpected error');
               }
            });                        
          }};
          
          $scope.answerFunction = function(prob) {
            $http.post("answerProblem.php",prob)
            .then(function(response){
                if(response.status == 200){
                    if(response.data.status == 'error'){
                        alert('error: ' + response.data.message);
                    }
                else {
                    alert('Answer Submitted!');
                    location.reload();
                }
                }else{
                    alert('unexpected error');
                }
            });
          };
        
        $scope.editavailability = function(time) {
            var startHours = time.start.getHours(); var startMins = time.start.getMinutes(); var endHours = time.end.getHours(); var endMins=time.end.getMinutes();
            function makeTwoDigit(num){
                num=num.toString();
                if(num.length==1){
                    num = "0" + num;
                }
                return num;
            }
            
            time.start = makeTwoDigit(startHours) + ':' + makeTwoDigit(startMins);
            time.end = makeTwoDigit(endHours)+':'+ makeTwoDigit(endMins);
            $http.post("editavailability.php",time)
            .then(function(response) {
                if(response.status ==200){
                    if(response.data.status =='error'){
                        alert('error:.'+response.data.message);
                    }else{
                        alert(response.data.r);
                        location.reload();
                        //successful
                    }
                }else{
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
