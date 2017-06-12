<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mrbs.MrbsDAO"%>
<%@ page import="mrbs.Mrbs"%>
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
		
		Mrbs mrbs = new MrbsDAO().getMrbs(mrbsID);
		
		if (!userID.equals(mrbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='mrbs.jsp'");
			script.println("</script>");
		}
		else {
				MrbsDAO mrbsDAO = new MrbsDAO();
				int result = mrbsDAO.delete(mrbsID);
				CmtDAO cmtDAO = new CmtDAO();
				
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					cmtDAO.deletePost(mrbsID);//게시글에 존재하는 댓글 삭제
					cmtDAO.reSort(mrbsID);//삭제하는 게시글보다 mrbsID 값이 큰 댓글 mrbsID = mrbsID-1 재정렬
					mrbsDAO.reSort(mrbsID);//삭제 후 글 번호 재정렬
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("location.href='mrbs.jsp'");
					script.println("</script>");
				}
			
		}
	%>
</body>
</html>