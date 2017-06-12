<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">
<title>No Food, No Life!</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>

	<header class="header"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a>
	<br>
	</header>
	<nav align="center">
	<ul class="nav">
		<div>
			<li><a href="introduce.jsp">Introduction</a></li>
			<li><a href="rbs.jsp">Recipe</a></li>
			<li><a href="mrbs.jsp">Community</a></li>
			<li><a href="notice.jsp">Notice&amp;QnA</a></li>
	</ul>
	</nav>
	<%
		if (userID == null) {
	%>
	<div align="right" class="login">
		<a href="login.jsp">로그인</a> | <a href="join.jsp">회원가입&nbsp;&nbsp;&nbsp;</a>
	</div>
	<%
		} else {
	%>
	<div align="right" class="login">
		<a href="logoutAction.jsp">로그아웃&nbsp;&nbsp;&nbsp;</a>
	</div>
	<%
		}
	%>
	</nav>

	<section class="carou">
	<div class="container">
		<h1
			style="font-family: 'Nanum Brush Script'; font-size: 60px; font-weight: bold">Today's
			recipes</h1>
		<div id="myCarousel" class="carousel slide" data-ride="carousel"
			data-interval="5000">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1" class=""></li>
				<li data-target="#myCarousel" data-slide-to="2" class=""></li>
			</ol>
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="img/1.jpg">
				</div>
				<div class="item">
					<img src="img/2.jpg">
				</div>
				<div class="item">
					<img src="img/3.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
		<hr>

	</div>

	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<footer class="footer" align="right">
	<hr>
	Copyright "No Food, No Life!" All Rights Reserved. </footer>
</body>
</html>