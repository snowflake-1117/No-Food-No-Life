<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mrbs.MrbsDAO"%>
<%@ page import="mrbs.Mrbs"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");

	String savePath = application.getRealPath("");
	int maxSize = 5 * 1024 * 1024;
	MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8",
			new DefaultFileRenamePolicy());
	String imgName = null;
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

		if (!userID.equals(mrbs.getUserID())&&!userID.equals("admin")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='mrbs.jsp'");
			script.println("</script>");
		} else {
			if (multi.getParameter("mrbsTitle") == null || multi.getParameter("mrbsContent") == null
					|| multi.getParameter("mrbsTitle").equals("") || multi.getParameter("mrbsContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				MrbsDAO mrbsDAO = new MrbsDAO();

				File imgFile = multi.getFile("mrbsImage");
				if (imgFile != null)
					imgName = imgFile.getName();

				int result;

				if (multi.getParameter("mrbsVideoSrc") == null || multi.getParameter("mrbsVideoSrc").equals("")) {
					result = mrbsDAO.update(mrbsID, multi.getParameter("mrbsCategory"), multi.getParameter("mrbsTitle"),
							multi.getParameter("mrbsContent"), null, imgName);
				} else {
					result = mrbsDAO.update(mrbsID, multi.getParameter("mrbsCategory"), multi.getParameter("mrbsTitle"),
							multi.getParameter("mrbsContent"),
							multi.getParameter("mrbsVideoSrc").replace("https://www.youtube.com/watch?v=", "")
									.replace("https://youtu.be/", ""),
							imgName);
				}

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script> ");
					script.println("location.href='mrbs.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>