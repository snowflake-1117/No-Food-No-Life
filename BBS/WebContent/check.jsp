<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	UserDAO userDAO = new UserDAO();
	User user = userDAO.getUser(userID);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">

<title>비밀번호 확인</title>
</head>
<body>
	<nav> <header class="header"
		style="font-size:60px; margin-top:100px;">
	<a href="main.jsp" style="text-decoration: none; color: #ff7846">No
		Food, No life!</a></header>
	<div class="container">

		<div
			style="margin-top: 200px; width: 380px; position: absolute; left: 50%; margin-left: -190px; margin-bottom: 100px;">
			<div class="jumbotron"
				style="padding-top: 15px; padding-bottom: 35px;">
				<form method="post" action="checkAction.jsp">
					<h3 style="text-align: center;">비밀번호를 입력하세요</h3><br>
					<div class="form-group">
						<input type="password" class="form-control" value="<%%>"
							placeholder="현재 비밀번호" name="userPassword" maxlength="20">
					</div><br>
					<input type="submit" class="btn btn-primary form-control"
						style="border: orange 1px solid; background-color: orange;"
						value="내 정보 수정하기">
				</form>
			</div>
		</div>
	</div>
	</nav>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>