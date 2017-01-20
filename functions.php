<?php

//Create Connection
function connectDatabase(){
  $connect = mysqli_connect('localhost', 'pma', 'bazzinga', 'Movie_Ticketing');

  //Check Connection
  if(mysqli_connect_errno($connect)){
    echo 'Failed to connect to database ' . mysqli_connect_error();
  }
  return $connect;
}

?>
