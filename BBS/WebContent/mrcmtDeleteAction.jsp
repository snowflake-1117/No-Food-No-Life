<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mrcmt.MrcmtDAO"%>
<%@ page import="mrcmt.Mrcmt"%>
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
		int mrcmtID = 0;
		if (request.getParameter("mrcmtID") != null) {
			mrcmtID = Integer.parseInt(request.getParameter("mrcmtID"));
		}
		if (mrcmtID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("location.href='mrbs.jsp'");
			script.println("</script>");
		}
		
		Mrcmt mrcmt = new MrcmtDAO().getMrcmt(mrcmtID);
		
		if (!userID.equals(mrcmt.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='mrbs.jsp'");
			script.println("</script>");
		}
		else {
			
				MrcmtDAO mrcmtDAO = new MrcmtDAO();
				int result = mrcmtDAO.delete(mrcmtID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					response.sendRedirect("mrbsView.jsp?mrbsID=" + mrcmt.getMrbsID());
					script.println("</script>");
				}
			
		}
	%>
</body>
</html>