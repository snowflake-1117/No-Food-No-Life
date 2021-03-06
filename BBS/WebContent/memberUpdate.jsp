<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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

	if (!userID.equals("admin")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자가 아닙니다.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
	UserDAO userDAO = new UserDAO();
	User user = userDAO.getUser(request.getParameter("userID"));
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">

<title>회원정보 변경</title>
</head>
<body>
	<nav> <header class="header"
		style="font-size:60px; margin-top:100px;"> <a href="main.jsp"
		style="text-decoration: none; color: #ff7846">No Food, No life!</a></header>
	<div class="container">

		<div
			style="margin-top: 200px; width: 450px; position: absolute; left: 50%; margin-left: -225px; margin-bottom: 100px;">
			<div class="jumbotron"
				style="padding-top: 15px; padding-bottom: 35px;">
				<form method="post" action="memberUpdateAction.jsp">
					<h3 style="text-align: center;">회원정보 수정</h3>
					<br>
					<table style="text-align: left; width: 350px;">
						<tr class="form-group">
							<td>아이디</td>
							<td><input type="text" class="form-control" name="userID"
								value="<%=user.getUserID()%>" maxlength="20" readonly></td>
						</tr>
						<tr class="form-group">
							<td>이름</td>
							<td><input type="text" class="form-control" name="userName"
								maxlength="20" value="<%=user.getUserName()%>" readonly></td>
						</tr>
						<tr class="form-group">
							<td>현재 비밀번호</td>
							<td><input type="text" class="form-control"
								name="userPassword" maxlength="20" value="<%=user.getUserPassword()%>" readonly></td>
						</tr>
						<tr class="form-group">
							<td>비밀번호</td>
							<td><input type="password" class="form-control"
								placeholder="변경할 비밀번호(6~16자)" name="newPassword" maxlength="20"></td>
						</tr>
						<tr class="form-group">
							<td>비밀번호 확인</td>
							<td><input type="password" class="form-control"
								placeholder="비밀번호 확인" name="newPassword_Re" maxlength="20"></td>
						</tr>
						<tr class="form-group">
							<td>이메일</td>
							<td><input type="email" class="form-control"
								placeholder="이메일" value="<%=user.getUserEmail()%>"
								name="userEmail" maxlength="50"></td>
						</tr>
					</table>
					<br> <input type="submit" class="btn btn-primary form-control"
						style="border: 1px solid orange; background-color: orange;"
						value="수정하기">
				</form>
			</div>
			<hr>
			<%
				if (!userID.equals("admin")) {
			%>
			<a onclick="return confirm('정말로 탈퇴하시겠습니까?')"
				href="mypageDeleteAction.jsp">탈퇴하기</a>
			<%
				}
			%>
		
	</nav>
	</div>
	</div>
	</nav>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>