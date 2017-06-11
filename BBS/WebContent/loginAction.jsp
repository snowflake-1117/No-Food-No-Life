<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>    
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPassword" name="user"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>board</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID!=null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 하였습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result==1){
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script> ");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result==0){
			PrintWriter script = response.getWriter();
			script.println("<script> ");
			script.println("alert('유효하지 않은 비밀번호입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result==-1){
			PrintWriter script = response.getWriter();
			script.println("<script> ");
			script.println("alert('아이디가 존재하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result==0){
			PrintWriter script = response.getWriter();
			script.println("<script> ");
			script.println("alert('데이터 베이스 에러')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>