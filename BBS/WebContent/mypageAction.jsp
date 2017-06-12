<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>No Food, No Life!</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			if (request.getParameter("newPassword") == null || request.getParameter("newPassword").equals("")
					|| request.getParameter("userEmail") == null || request.getParameter("userEmail").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다. ')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else if (!request.getParameter("newPassword").equals(request.getParameter("newPassword_Re"))||(request.getParameter("newPassword").length()<6)) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호를 다시 확인해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
				UserDAO userDAO = new UserDAO();

				int result = userDAO.update(request.getParameter("newPassword"), request.getParameter("userEmail"), userID);

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("alert('회원정보 변경에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("location.href='main.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>