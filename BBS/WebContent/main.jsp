<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<!-- <link rel="stylesheet" href="css/bootstrap.css"> -->
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

	 <header class="header">
      <a href="main.jsp" style="text-decoration: none; color:#ff7846">No Food, No life!</a><br>
   	</header>
	<nav align="center">
      <ul class="nav" ><div>
        <li><a href="introduce.html">Introduction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
        <li><a href="Recipes.html">Recipe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
        <li><a href="bbs.jsp">Community&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
        <li><a href="notice.html">Notice&amp;QnA</a></li></ul>
    </nav>
		<%
			if (userID == null) {
		%>
		<div align="right" class="login">
     		<a href="login.jsp">로그인</a> | 
     		<a href="join.jsp">회원가입&nbsp;&nbsp;&nbsp;</a>
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

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>