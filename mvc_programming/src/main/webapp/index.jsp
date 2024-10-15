<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  



<%
String msg="";
if(session.getAttribute("msg") != null){
	msg = (String)session.getAttribute("msg");
}
session.setAttribute("msg","");




%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here..,...</title>
<link href="./css/style.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
<%if(!msg.equals("")) { %>
	alert('<%=msg%>');
<%}%>
</script>


<style>


.main {
	width : 600px;
	height : 300px;
	text-align : center;
	margin : 50px;
	border : 5px solid skyblue; 
	padding : 50px;
	
	
}


</style>


</head>
<body>

<div class="main">메인페이지 입니다....yhhhuyyuyhiuhihijnujihh.</div>
<div>
<a href="<%=request.getContextPath() %>/member/memberJoin.aws">회원가입 페이지 가기</a>
</div>

<div>
<a href="<%=request.getContextPath() %>/member/memberLogin.aws">회원로그인 페이지 가기</a>
회원로그인하기
</div>

</body>
</html>
