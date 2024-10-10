<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>String 객체 메소드 사용해보기</title>
</head>
<body>
	<script>
	let str = new String("dream come true");  // 스트링 클래스 생성자 호출, String 클래스 생성자 안에 인자값 담아서 호출
	
	// IndexOf
	let position = str.indexOf("come");
	document.write("come 자리 위치는?" + position);
	document.write("<br>");
	
	let position2 = str.indexOf("hello");
	document.write("hello 자리 위치는?" + position2);
	document.write("<br>");
	
	
	if (position2 == -1) {
		document.write("해당하는 단어는 포함되어 있지 않습니다.");
		
	}else{
		document.write("해당하는 단어는" +position2+ "번 자리에 있습니다.");
		
	}
	
	let str3 = prompt("글자를 입력하세요","");
	let position3 = str3.indexOf("good"); // good 이라는 값이 있는지 없는지 체크한다. 
	
	if (position3 == -1) {
		document.write("해당하는 단어는 포함되어 있지 않습니다.");
		
	}else{
		document.write("해당하는 단어는" +position3+ "번 자리에 있습니다.");
		document.write("<br>");
		
	}
	document.write("<br>");
	
	// substr 함수 : 글자 자르기
	let str4 = "무궁화 꽃이 피었습니다.";
	let value = str4.substr(6,3);  // 6번부터 3개 (0번부터 시작함)
	document.write("값은?" + value);
	document.write("<br>");
	let value2 = str4.substring(2,4);  // 2번 다음부터 4번자리까지
	document.write("값2은?" + value2);
	document.write("<br>");
	
	let s = " 안녕    ";
	let ss = s.trim();
	document.write("공백제거?" + ss);
	
	



	</script>

</body>
</html>