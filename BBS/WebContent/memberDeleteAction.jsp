<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="cmt.CmtDAO"%>
<%@ page import="cmt.Cmt"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>board</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		String userID = request.getParameter("userID");
		int result = userDAO.deleteID(userID); 
	%>
	<script> alert("삭제되었습니다.")</script>
	<%
		PrintWriter script = response.getWriter();
		script.println("<script> ");
		script.println("location.href='memberInfo.jsp'");
		script.println("</script>");

	%>
</body>
</html>