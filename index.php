<?php
include 'functions.php';
connectDatabase();

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
								 <li>
									<a href="book.php">Book Now</a></li>
							</ul>
							<a href="#" class="close">Close</a>
						</div>
					</nav>

				<!--Main Banner -->
					<section id="banner">
						<div class="inner">
							<div class="logo"><span class="icon fa-ticket"></span></div>
							<h2>Online Ticketing made easy</h2>
						</div>
						<div id="slideshow">
						   <div>
						     <img class="bannerSize" src="http://wallpaperspal.com/wp-content/uploads/Paul-Walker-Furious-7-Poster-Wallpaper-800x500.jpg">
						   </div>
						   <div>
						     <img class="bannerSize" src="http://www.nextgenhometheater.com/wp-content/uploads/2015/11/chappie-movie-poster-2015-wallpaper-robot-die-antwoord-1038x576.jpg">
						   </div>
						   <div>
						     <img class="bannerSize" src="http://i.imgur.com/hMUer.jpg">
						   </div>
							 <div>
						     <img class="bannerSize" src="http://nos.nl/data/image/2015/10/22/219269/xxl.jpg">
						   </div>
						</div>
					</section>

				<!-- Wrapper -->
				<section id="wrapper">

						<!-- Sample Movie -->
							<!-- <section id="one" class="wrapper spotlight style1">
								<div class="inner">
									<a href="#" class="image"><img src="images/pic01.jpg" alt="" /></a>
									<div class="content">
										<h2 class="major">Magna arcu feugiat</h2>
										<p>Lorem ipsum dolor sit amet, etiam lorem adipiscing elit. Cras turpis ante, nullam sit amet turpis non, sollicitudin posuere urna. Mauris id tellus arcu. Nunc vehicula id nulla dignissim dapibus. Nullam ultrices, neque et faucibus viverra, ex nulla cursus.</p>
										<a href="#" class="special">Book Now</a>
									</div>
								</div>
							</section> -->

						<!-- Movie List -->
							<section id="four" class="wrapper alt style1">
								<div class="inner">
									<h2 class="major">New Movies</h2>
									<p>Cras mattis ante fermentum, malesuada neque vitae, eleifend erat. Phasellus non pulvinar erat. Fusce tincidunt, nisl eget mattis egestas, purus ipsum consequat orci, sit amet lobortis lorem lacus in tellus. Sed ac elementum arcu. Quisque placerat auctor laoreet.</p>
									<section class="features">
										<article>
											<a href="#" class="image"><img src="http://40.media.tumblr.com/26b27457825184d130f68c3d6bd723b7/tumblr_nilpe6fgrD1r9uv98o1_500.jpg" alt="" /></a>
											<h3 class="major">The Imitation Game</h3>
											<p>Lorem ipsum dolor sit amet, consectetur adipiscing vehicula id nulla dignissim dapibus ultrices.</p>
											<a href="book.php" class="special">Book Now</a>
										</article>
										<article>
											<a href="#" class="image"><img src="http://40.media.tumblr.com/26b27457825184d130f68c3d6bd723b7/tumblr_nilpe6fgrD1r9uv98o1_500.jpg" alt="" /></a>
											<h3 class="major">Nisl placerat</h3>
											<p>Lorem ipsum dolor sit amet, consectetur adipiscing vehicula id nulla dignissim dapibus ultrices.</p>
											<a href="book.php" class="special">Book Now</a>
										</article>
										<article>
											<a href="#" class="image"><img src="http://40.media.tumblr.com/26b27457825184d130f68c3d6bd723b7/tumblr_nilpe6fgrD1r9uv98o1_500.jpg" alt="" /></a>
											<h3 class="major">Ante fermentum</h3>
											<p>Lorem ipsum dolor sit amet, consectetur adipiscing vehicula id nulla dignissim dapibus ultrices.</p>
											<a href="book.php" class="special">Book Now</a>
										</article>
										<article>
											<a href="#" class="image"><img src="http://40.media.tumblr.com/26b27457825184d130f68c3d6bd723b7/tumblr_nilpe6fgrD1r9uv98o1_500.jpg" alt="" /></a>
											<h3 class="major">Fusce consequat</h3>
											<p>Lorem ipsum dolor sit amet, consectetur adipiscing vehicula id nulla dignissim dapibus ultrices.</p>
											<a href="book.php" class="special">Book Now</a>
										</article>
									</section>
									<ul class="actions">
										<li><a href="book.php" class="button">Browse All</a></li>
									</ul>
								</div>
							</section>

					</section>

				<!-- Footer -->
					<section id="footer">
						<div class="inner">

							<ul class="copyright">
								<li>&copy; 2015, All rights reserved.</li>
							</ul>
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
