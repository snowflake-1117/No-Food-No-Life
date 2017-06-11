<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rbs.RbsDAO"%>
<%@ page import="rcmt.RcmtDAO"%>
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
<title>board</title>
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
		}
		
		int rbsID = 0;
		if (request.getParameter("rbsID") != null) {
			rbsID = Integer.parseInt(request.getParameter("rbsID"));
		}
		if (rbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("location.href='rbs.jsp'");
			script.println("</script>");
		}

		if (request.getParameter("rcmtContent") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			RcmtDAO rcmtDAO = new RcmtDAO();
			int result = rcmtDAO.write(userID, request.getParameter("rcmtContent"), rbsID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script> ");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				response.sendRedirect("rbsView.jsp?rbsID=" + rbsID);
			}
		}
	%>
</body>
</html>