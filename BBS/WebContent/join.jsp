<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width" name="viewport" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>게시판</title>
<<<<<<< HEAD
=======
<script>
function idCheck(){//아이디길이 4~12자 제한 체크, 영문+숫자인지 체크
	var id= document.addform.userID.value;
	var str = /^[A-Za-z0-9_-]{4,12}/; //아이디 영문대소문자,숫자,(_)로만 구성하도록 검사할 정규표현식
	
	if(!str.test(id)){//아이디(id)가 str의 범주에 해당할 경우(영문대소문자나 숫자,(_)가 아닐 경우)+글자 수 만족 안 할 때 조건문이 참이된다.
		alert("아이디를 4~12글자의 영문대소문자+숫자,(_)로  입력해주세요.");		
		return false; 
	}
	return true;//아이디 제대로 입력시 true 반환
}

function passCheck(){ //비밀번호, 비밀번호 확인 같은지 체크
	 var pass= document.addform.userPassword.value;
	 var str = /^[A-Za-z0-9_-]{6,16}$/;//비밀번호를 영문대소문자,숫자,(_)로만 구성하도록 검사할 정규표현식

	 if(!str.test(pass)){//비밀번호(pass)가 str의 범주에 해당할 경우(영문대소문자나 숫자,(_)가 아닐 경우)+글자수 만족 안 할 때 조건문이 참이된다.
		 alert("비밀번호를 6~16글자의 영문대소문자+숫자,(_)로  입력해주세요.");
	 }
	 else if(document.addform.userPassword.value!=document.addform.userPassword_Re.value){
		 //비밀번호와 비밀번호 확인의 값이 다를 경우
		 alert('비밀번호가 일치하지 않습니다');
	 }
}

function memReg(){//가입하기 전 id길이와 비밀번호 체크
	var v = idCheck();//v는 아이디 제대로 입력시 true, 그렇지 않을시 false가 된다.
	if(v)//아이디가 제대로 입력됐다면 비밀번호 검사실행, 아니면 비밀번호 체크 함수는 실행하지 않음.
		passCheck();
	
}
</script>
>>>>>>> Hyoeun_JOIN
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;">
<<<<<<< HEAD
					<form method="post" action="joinAction.jsp">
						<h3 style="text-align:center;">회원가입 화면</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="10">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						</div>
						<div class="form-group">
=======
					<form method="post" action="joinAction.jsp" name="addform">
						<h3 style="text-align:center;">회원가입 화면</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디(4~12자)" name="userID" maxlength="10" onblur="ID_Check()">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호(6~16자)" name="userPassword" maxlength="20">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호 확인" name="userPassword_Re" maxlength="20">
 						</div>
						<div class="form-group">
>>>>>>> Hyoeun_JOIN
							<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
						</div>
						<div class="form-group">
							<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50">
						</div>
<<<<<<< HEAD
						<input type="submit" class="btn btn-primary form-control" value="회원가입">
=======
						<input type="submit" onclick="memReg()" class="btn btn-primary form-control" value="회원가입">
>>>>>>> Hyoeun_JOIN
					</form>
				</div>
			</div>
		</div>
	</nav>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>