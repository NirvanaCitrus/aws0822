<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bom 객체로 타이머 사용하기</title>
</head>
<body>

<img id="img" src="../images/strawberry.png" 
onmouseover="startTimer(5000);"
onmouseout="cancelTimer();"
>


<button onclick="window.open('./javascript_size.jsp','test','width=300,height=300')">
버튼 크기 조절 눌러보려고
</button>

<script>
let timerID = null;
function startTimer(time) {
	timerID = setTimeout("load('http://naver.com')",time);
	
	
}

function load(url) {
	window.document.location.href = url;  // 이동한다
	
	
	
}

function cancelTimer() {
	clearTimeout(timerID);  // 타이머를 정리한다
}

</script>



</body>
</html>