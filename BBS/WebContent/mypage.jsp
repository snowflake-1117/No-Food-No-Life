<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	
	UserDAO userDAO = new UserDAO();
	User user = userDAO.getUser(userID);
	
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<script>
	function passCheck() { //비밀번호, 비밀번호 확인 같은지 체크
		var pass = document.addform.userPassword.value;
		var str = /^[A-Za-z0-9_-]{6,16}$/;//비밀번호를 영문대소문자,숫자,(_)로만 구성하도록 검사할 정규표현식
		if (!str.test(pass)) {//비밀번호(pass)가 str의 범주에 해당할 경우(영문대소문자나 숫자,(_)가 아닐 경우)+글자수 만족 안 할 때 조건문이 참이된다.
			alert("비밀번호를 6~16글자의 영문대소문자+숫자,(_)로  입력해주세요.");
			document.addform.userPassword.focus();
			return false;
		} else if (document.addform.userPassword.value != document.addform.userPassword_Re.value) {
			//비밀번호와 비밀번호 확인의 값이 다를 경우
			alert('비밀번호가 일치하지 않습니다');
			document.addform.userPassword_Re.focus();
			return false;
		}
		return true;
	}
	function emailCheck() {
		var email = document.addform.userEmail.value;
		var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

		if (regex.test(email) == false) {
			alert("잘못된 이메일 형식입니다.");
			return false;
		} else
			return true;

	}

	function memReg() {//가입하기 전 id길이와 비밀번호 체크
		var v = passCheck();
		if (v)
			var v = emailCheck();
		if (v)
			document.addform.submit();

	}
</script>
</head>
<body>
	<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="main.jsp"></a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
			<li><a href="bbs.jsp">게시판</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="mypageAction.jsp">
					<h3 style="text-align: center;">비밀번호 및 이메일 변경</h3>
					<div class="form-group">
						<input type="password" class="form-control" value="<%%>"
							placeholder="변경할 비밀번호(6~16자)" name="newPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호 확인"
							name="newPassword_Re" maxlength="20">
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" value="<%=user.getUserEmail() %>"
							name="userEmail" maxlength="50">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="수정하기">
				</form>
			</div>
		</div>
	</div>

	<a href="mypageDeleteAction.jsp">탈되하기</a></nav>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>