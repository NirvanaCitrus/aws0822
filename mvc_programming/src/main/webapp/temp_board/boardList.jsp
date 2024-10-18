<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글목록</title>
<style>
body {
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
	width: 800px;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

h3 {
	border-bottom: 2px solid #ff7a00;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
}

th {
	background-color: #f2f2f2;
	text-align: center;
}

.list {
	display: flex;
	justify-content: flex-end; /* 콘텐츠 항목 사이와 주위에 공간을 분배, 아이템들 끝점으로 분배 */
	margin-bottom: 20px;
}

select, input[type="text"], button {
	padding: 5px;
	margin-right: 5px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

button {
	background-color: #333;
	color: #fff;
	cursor: pointer;
}

button:hover {
	background-color: #ff7a00;
}

a {
	text-decoration: none;
	color: #333;
}

a:hover {
	color: #ff7a00;
}
</style>

</head>
<body>
	<div class="container">
		<h3>글목록</h3>
		<div class="list">
			<form name="frm">
				<select name="search">
					<option value="title">제목</option>
					<option value="author">작성자</option>
				</select> <input type="text" name="keyword" placeholder="검색어를 입력하세요">
				<button type="submit">검색</button>
			</form>
		</div>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="text-align: center;">170</td>
					<td style="text-align: left;"><a href="<%=request.getContextPath()%>/board/boardContent.aws">장애학생들을 위한 특별한 피아노</a></td>
					<td style="text-align: center;">관리자</td>
					<td style="text-align: center;">7</td>
					<td style="text-align: center;">2024-10-12</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>