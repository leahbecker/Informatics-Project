 <div class="row">
        
        <div class="col text-left">
             
            <button class = "btn btn-dark align-right" ng-disabled="home" onClick = "history.back()">Home</button>
        </div>
        <div class="col text-right">
            <button class="btn btn-dark align-right" ng-click="logout()">Logout, <?php
            session_start();
            $firstName = $_SESSION['name'];
            echo "$firstName";
            ?>       </button>
        </div>
</div>