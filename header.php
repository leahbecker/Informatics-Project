
 <div class="row">
        
        <div class="col text-left">
             
            <!--<button class = "btn btn-dark align-right" ng-disabled="home" onClick = "history.back()">Back</button>-->
            <button class = "btn btn-dark align-right" ng-click ="goHome('<?php session_start(); $userRole = $_SESSION['role']; echo "$userRole";?>')"
            ng-hide ="home==true">Home</button>
        </div>
       <!-- sessions remaining widget -->
    <div ng-show ="role =='student'" class="float-right" style="margin-top: .25rem">
        <div class="card bg-dark text-warning" style="width: 16rem">
            <!--<h6 class="card-header" style="text-align: center">Sessions remaining:</h6>-->
            <p class="card-header" style="text-align: center" >Sessions remaining:  {{sessions.sessionsRemaining}}</p>
        </div>
    </div>
        <div class="col text-right">
            <button class="btn btn-dark align-right" ng-click="logout()">Logout, <?php
            session_start();
            $firstName = $_SESSION['name'];
            echo "$firstName";
            ?>       </button>
        </div>
 </div>
