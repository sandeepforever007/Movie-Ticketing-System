<?php
include 'functions.php';
connectDatabase();
?>

<!DOCTYPE HTML>

<html>
	<head>
		<title>Tekket - Signup</title>
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
						<h1><a href="index.php">Teket</a></h1>
						<nav>
							<a href="#menu">Menu</a>
						</nav>
					</header>

				<!-- Menu -->
					<nav id="menu">
						<div class="inner">
							<h2>Menu</h2>
							<ul class="links">
								<li><a href="index.php">Home</a></li>
								<li><a href="login.php">Log In</a></li>
								<li><a href="signup.php">Sign Up</a></li>
							</ul>
							<a href="#" class="close">Close</a>
						</div>
					</nav>

				<!-- Wrapper -->
					<section id="wrapper">

						<!-- Content -->
							<div class="login-outter-wrap">
								<div class="inner signup-wrapper">
									<h2 class="major">Signup to use Tekket</h2>
									<form name="signupForm" method="post" action="scripts/signupScript.php">
										<div class="field">
                      <div class="field">
  											<label for="name">First Name</label>
  											<input type="text" name="firstname" id="firstname" required/>
  										</div>
                      <div class="field">
  											<label for="name">Last Name</label>
  											<input type="text" name="lastname" id="lastname" required/>
  										</div>
											<label for="name">Email</label>
											<input type="email" name="username" id="username" required/>
										</div>
										<div class="field">
											<label for="name">Password</label>
											<input type="password" name="passowrd" id="password" required/>
										</div>
										<div class="field">
											<label for="name">Address Line1</label>
											<input type="text" name="add1" id="add1" required/>
										</div>
										<div class="field">
											<label for="name">Address Line2</label>
											<input type="text" name="add2" id="add2" />
										</div>
										<div class="field">
											<label for="name">city</label>
											<input type="text" name="city" id="city" required/>
										</div><div class="field">
											<label for="name">state</label>
											<input type="text" name="state" id="state" required/>
										</div><div class="field">
											<label for="name">zip</label>
											<input type="text" name="zip" id="zip" required=/>
										</div><div class="field">
											<label for="name">Name on card</label>
											<input type="text" name="nameoncard" id="nameoncard"/>
										</div>
										<div class="field">
											<label for="name">Expiry Date</label>
											<input type="text" name="expirydate" id="expirydate" required/>
										</div>
										<div class="field">
											<label for="name">CVV</label>
											<input type="text" maxlength="3" name="cvv" id="cvv" required/>
										</div>
										<div class="field">
											<label for="name">Card Number</label>
											<input type="text" maxlength="16" name="cardnumber" id="cardnumber" required/>
										</div>
										<ul class="actions">
											<li><input type="submit" value="Sign Up" /></li>
										</ul>
									</form>
								</div>
							</div>

					</section>

			</div>

		<!-- Scripts -->
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
