<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 연습하기</title>
</head>
<body onload="alert('모든 객체가 생성된 후에 로딩됩니다.');">
<script>
window.onload=function() {
	alert('모든 객체가 생성된 후에 로딩됩니다2');
}


function calculate() {
	let exp = documet.getElementById("exp");  //exp input 객체 찾기
	let result = documet.getElementById("result"); // result input 객체 찾기
	
	result.value = eval(exp.value); // 계산해서 담기
	
	return;
}

/* function aaa() {
	alert("오른쪽 버튼은 사용금지입니다");
	return false;
} */

//document.oncontextmenu = aaa;

function changeImage() {
	//alert("함수에 들어왔나요?");
	let sel = document.getElementById("sel"); //select 객체 찾기
	//alert("객체가 생성되었나요?" + sel);
	let img = document.getElementById("myImg");
	//alert("객체가 생성되었나요?" + img);
	
	//img.onload = function(){ // 이미지가 로딩이 되면 익명함수 동작
		//alert("이미지가 로딩되었나요?");
		let mySpan = document.getElementById("mySpan");
		//alert("객체가 생성되었나요?" + mySpan);
		mySpan.innerHTML = img.width + "X" + img.height;
		
	//}
	let index = sel.selectedIndex;
	//alert(index);
	//alert(sel.options[index],value)
	img.src = sel.options[index].value;
	//alert(img.src);
}

let hasChecked = false; // 중복 실행 방지용 변수

function chk() {
	if (hasChecked) {
		return;
		
	}
	
		
	alert("chk함수안에 들어왔음");
	let nm = document.getElementById("nm");
	alert("nm객체 생성되었음"+nm);
	
	if(nm.value=="") {
		alert("아무것도 입력하지 않았음. 포커스로 다시 입력하게 하겠음");
		hasChecked = true;
		nm.focus();
		return;
		
	}
	
	return;
}

</script>
<form>
<input type="text" id="exp" value="">
<br>
<input type="test" id="result">
<br>
<input type="button" value="계산하기" onclick="calculate();">

<hr>

<p>
마우스 오른쪽 버튼 클릭하기 해보는 테스트

</p>

<hr>
<form>
<select id="sel" onchange="changeImage();">
<option value="../images/apple.png">사과</option>
<option value="../images/banana.png">바나나</option>
<option value="../images/strawberry.png">딸기</option>


</select>

</form>
<span id="mySpan">이미지 크기</span>
<p>
<img id="myImg" src="../images/apple.png" title="사과">
</p>

<input type="text" name="nm" id="nm" onblur="chk();"> <!-- 그 위치를 떠날때 감지하는 이벤트 -->


</form>



</body>
</html>