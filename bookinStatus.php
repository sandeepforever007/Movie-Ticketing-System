<?php
include 'functions.php';
connectDatabase();

//Start session
session_start();
?>

<!DOCTYPE HTML>

<html>
	<head>
		<title>Tekket - Bookings</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />

		<link rel="stylesheet" href="assets/css/main.css" />
		<link rel="stylesheet" href="assets/css/custom.css" />
	</head>
	<body>

		<!-- Page Wrapper -->
			<div id="page-wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="index.php">Tekket</a></h1>
						<nav>
							<a href="#menu"><?php
							if (isset($_SESSION["user"])){
								echo $_SESSION["user"];
							}else{
								echo "Menu";
							}

							 ?></a>
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
								 <li>
									<a href="book.php">Book Now</a></li>
							</ul>
							<a href="#" class="close">Close</a>
						</div>
					</nav>

				<!-- Wrapper -->
					<section id="wrapper">

						<!-- Content -->
						<div class="container">
							<div class="bookings" id="bookings">
								<h2>Get ready for the show, Your ticket booking is successfull!</h2>
								<a href="#" class="button small fit" id="booking-history">Booking History</a>
							</div>
							<div id="history" style="display: none;">
								
							</div>
						</div><!-- container -->
					</section>

			</div>

		<!-- Scripts -->
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
			<script src="assets/js/custom.js"></script>

	</body>
</html>
