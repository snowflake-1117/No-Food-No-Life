<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mrbs.MrbsDAO"%>
<%@ page import="mrbs.Mrbs" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="java.io.File"%>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mrbs" class="mrbs.Mrbs" scope="page"></jsp:useBean>
<jsp:setProperty property="mrbsCategory" name="mrbs" />
<jsp:setProperty property="mrbsTitle" name="mrbs" />
<jsp:setProperty property="mrbsVideoSrc" name="mrbs" />
<jsp:setProperty property="mrbsContent" name="mrbs" />
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
		int mrbsID = 0;
		if (request.getParameter("mrbsID") != null) {
			mrbsID = Integer.parseInt(request.getParameter("mrbsID"));
		}
		if (mrbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='mrbs.jsp'");
			script.println("</script>");
		}
		else {
				MrbsDAO mrbsDAO = new MrbsDAO();
				int result = mrbsDAO.like(mrbsID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("alert('추천에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					response.sendRedirect("mrbsView.jsp?mrbsID="+mrbsID);
				}
			}
	%>
</body>
</html>