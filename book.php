<?php
include 'functions.php';
$connect = connectDatabase();

//Start session
session_start();
?>

<!DOCTYPE HTML>

<html>
	<head>
		<title>Tekket</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />

		<link rel="stylesheet" href="assets/css/main.css" />
		<link rel="stylesheet" href="assets/css/custom.css" />
		<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"> -->
	</head>
	<body>

		<!-- Page Wrapper -->
			<div id="page-wrapper">

				<!-- Header -->
					<header id="header" class="alt">
						<h1><a href="index.php">Tekket</a></h1>
						<nav>
							<a href="#menu">
								<?php

								if (isset($_SESSION["user"])){
									echo $_SESSION["user"];
								}else{
									echo "Menu";
								}
								 ?>
							</a>
						</nav>
          </header>

  				<!-- Menu -->
					<nav id="menu">
						<div class="inner">
							<h2>
								<?php
								if (isset($_SESSION["user"])){
									echo $_SESSION["user"];
								}else{
									echo "Menu";
								}
								 ?>
							</h2>
							<ul class="links">
								<li><a href="index.php">Home</a></li>
								<?php
								if (isset($_SESSION["user"])){
									echo "<li><a href='scripts/logoutScript.php'>Logout</a></li>";
								}else{
									echo "<li><a href='login.php'>Login</a></li>";
								}
								 ?>
								 <li><a href="book.php">Book Now</a></li>
							</ul>
							<a href="#" class="close">Close</a>
						</div>
					</nav>

					<section class="container">
						<div class="errorMessage">
						<?php
						if (isset($_SESSION['loginAlert'])){
							echo "<div class='alert'>";
							echo "<span class='icon fa-times-circle fa-2x'></span><h3>Please login to book tickets</h3></div>";
							unset($_SESSION['loginAlert']);
						}
						 ?>
					 </div>
						<form name="booking" method="post" action="scripts/bookingScript.php">
							<div class="column3">
								<h4>Select City</h4>
									<select name="city-list" id="city-list">
										<option value="">--</option>
										<?php
										$query = "CALL cityList()";
										$stmt = $connect->query($query);
										while ($row = $stmt->fetch_assoc()){
											echo "<option value=".$row['city'].">".$row['city']."</option>";
										}
										 ?>
									</select>

							 </div>
							 <div class="column3" id="movie-list" style="display: none;">
							 </div>
							 <div class="column3" id="theatre-list" style="display: none;">
							 </div><br>
							 <div class="container" id="shows-list" style="display: none;">
							 </div>
						</form>
					</section>



		<!-- Scripts -->
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/jquery.min.js"></script>
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
			<script src="assets/js/custom.js"></script>

	</body>
</html>
