<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE> 회원로그인 </TITLE>
<style>

header {
	width:100%;
	height: 100px;
	text-align:center;
	--background-color:white;
}

nav {
	width: 15%; 
	height: 300px; 
	float: left;
	--background-color:white;

}

section {
	width: 70%;
	height: 300px;
	float: left;
	--background:olivedrab;


}

aside {
	width: 15%;
	height: 300px;
	float: left;
	--background:orange;

}

footer {
	width: 100%;
	height: 15%;
	clear: both;
	text-align:center;
	--background:plum;



}

body {
	background-color:skyblue;
	margin:0px;

}

input[type=text] {
	background : gray;
}



</style>


 </HEAD>

 <BODY>

 <header>회원로그인 페이지</header>
 <nav></nav>
 <section>
	<article>
	<div id="parent">
	<div id ="child">
<form name="frm" action=".test0920_result.html" method="post">

	<style>
		table {
			margin:0 auto;



		}

	</style>
	<table border=1 style="length:300px;">
	<tr> 
	<th>아이디</th>
			<td>
				<input type="text" name="memberId" style="width:150px;" maxlength="30">
			</td>
	</tr>
	<tr> 
	<th>비밀번호</th>
			<td>
				<input type="password" name="memberPwd" style="width:150px;" maxlength="30">
			</td>
	</tr>
	
	<tr>
		<td colspan=2 style="text-align:center;">
			<input type="button" name="btn" value="로그인">
		</td>
	</tr>

	<tr>
		<td>
			<input type="button" name="btn" value="아이디 찾기">
		</td>
		<td>
			<input type="button" name="btn" value="비밀번호 찾기">
		</td>

	</tr>


	</table>
</form>		
	
	
	
	</article>
 </section>
 <aside>
 </aside>


 <footer>
 made by META.
 </footer>
 </BODY>
</HTML>
