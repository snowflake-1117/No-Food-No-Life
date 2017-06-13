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
		if (!userID.equals("admin")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자가 아닙니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			if ((request.getParameter("newPassword") == null || request.getParameter("newPassword").equals(""))
					&& (request.getParameter("userEmail") == null
							|| request.getParameter("userEmail").equals(""))) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이메일이나 비밀번호 중 최소 한 가지는 수정해야 합니다. ')");
				script.println("history.back()");
				script.println("</script>");
			} else if ((request.getParameter("newPassword") != null
					&& !request.getParameter("newPassword").equals(""))
					&& (!request.getParameter("newPassword").equals(request.getParameter("newPassword_Re"))
							|| request.getParameter("newPassword").length() < 6)) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호를 다시 확인해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				UserDAO userDAO = new UserDAO();

				int result;

				if (request.getParameter("newPassword") != null && !request.getParameter("newPassword").equals("")
						&& request.getParameter("userEmail") != null
						&& !request.getParameter("userEmail").equals("")) {
					result = userDAO.update(request.getParameter("newPassword"), request.getParameter("userEmail"),
							request.getParameter("userID"));
				} else if (request.getParameter("newPassword") == null
						|| request.getParameter("newPassword").equals("")) {
					result = userDAO.userEmailUpdate(request.getParameter("userEmail"), request.getParameter("userID"));
				} else if (request.getParameter("userEmail") == null
						|| request.getParameter("userEmail").equals("")) {
					result = userDAO.userPasswordUpdate(request.getParameter("newPassword"), request.getParameter("userID"));
				}
				else result = -1;

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("alert('회원정보 변경에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("alert('회원정보 변경에 성공했습니다.')");
					script.println("location.href='memberInfo.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>