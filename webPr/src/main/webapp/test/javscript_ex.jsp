<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예제문제</title>
</head>
<body>

<script>
function findPerson () {
	let spans = document.getElementsByClassName("a");
	for (let span of spans) {
		span.style.color = "orange";
		span.style.fontSize = "30px";
	}
}


</script>



1. 다음 문장에서 사람 이름에 해당하는 문장은 글자크기를 30px로 작성하고 색상은 orange 색으로 표현

<hr>
<span class="a">이순신</span> 장군은 배 12척을 가지고 명량해전을 대승으로 이끌었다<br>
<span class="a">홍길동</span>은 아버지를 아버지라 부르지 못하고 가출했다<br>
<span class="a">강감찬</span>은 귀주대첩의 유명한 장군이다<br>
<span class="a">김한수</span>는 내 학교 선배였다.<br>

<button type = "button" onclick="findPerson();">사람을 찾기</button>




</body>
</html>