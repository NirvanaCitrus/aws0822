<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.util.*" %>
<%@page import = "mvc.vo.*" %>    
<% 
ArrayList<BoardVo> alist = (ArrayList<BoardVo>)request.getAttribute("alist");
//System.out.println("alist==>" +alist);

PageMaker pm = (PageMaker)request.getAttribute("pm");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 작업</title>
<style>
table {
	border-collapse: collapse;
	border-spacing: 0;
}

section.notice{
	padding: 80px 0;
}

.page-title {
  margin-bottom: 60px;
}

.page-title h3 {
  font-size: 28px;
  color: #333333;
  font-weight: 400;
  text-align: center;
}

#board-search .search-window {
padding: 15px 0;
background-color: gray;
}

#board-search .search-window .search-wrap{
position: relative;
margin: 0 auto;
width: 80%;
max-width: 564px;
}

#board-search .search-window .search-wrap input {
  height: 40px;
  width: 100%;
  font-size: 14px;
  padding: 7px 14px;
  border: 1px solid #ccc;
}

#board-search .search-window .search-wrap input:focus {
border-color: #333;
outline: 0;
border-width: 1px;
}

#board-search .search-window .search-wrap .btn {
position: absolute;
right: 0;
top: 0;
bottom: 0;
width: 108px;
padding: 0;
font-size: 16px;
}


.board-table{
font-size: 13px;
width: 100%;
border-top: 1px solid #ccc;
border-bottom: 1px solid #ccc;

}

.board-table a {
color: #333;
display: inline-block;
line-height: 1.4;
word-break: break-all;
vertical-align: middle;
}

.board-table a:hover{
text-decoration: underline;
}

.board-table th {
text-align: center;
}

.board-table .th-num {
width: 100px;
text-align: center;

}

.board-table .th-date {
width: 200px;

}

.board-table th, .board-table td{
padding: 14px 0;
}

.board-table tbody th {
padding-left: 28px;
padding-right: 14px;
border-top: 1px solid #000;
text-align: left;

}

.board-table tbody td {
border-top: 1px solid #e7e7e7;
text-align: center;
}

.board-table tbody th p{
display: none;

}

.container {
width: 1100px;
margin: 0 auto;
}

.blind {
position: absolute;
overflow: hidden;
clip: rect(0 0 0 0);
margin: -1px;
width: 1px;
height: 1px;
}

.btn {
display: inline-block;
padding: 0 30px;
font-size: 15px;
font-weight: 400;
background: transparent;
text-align: center;
white-space: nowrap;
vertical-align: middle;
cursor: pointer;
border: 1px solid transparent;
text-transform: uppercase;


}

.btn-dark {
background: #555;
color: #fff;
list-style: none;
text-decoration: none;
padding: 0;
margin: 0;
box-sizing: border-box;
}

.page ul {
    display: flex; /* Makes the items in the list horizontally aligned */
    justify-content: center; /* Centers the items */
    list-style: none; /* Removes the bullet points */
    padding: 0; /* Removes any default padding */
}

.page ul li {
    margin: 0 5px; /* Adds spacing between the page numbers */
}

.page ul li a {
    display: block;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
}

.page ul li a:hover {
    background-color: #eee;
}

.page ul li.on a {
    background-color: #555;
    color: #fff;
}



</style>

</head>
<body>
<section class="list">
	<div class="page-title">
		<div class="container">
			<h1>글 목록</h1>
		</div>			
	</div>
	
	<!-- 검색 부분 -->
	<div id="board-search">
		<div class="container">
			<div class="search-window">
				<form action="">
					<div class="search-wrap">
						<label for="search" class="blind">검색기능</label>
						<input id="search" type="search" name="" placeholder="검색어를 입력하세요." value="">
						<button type="submit" class="btn btn-dark">검색</button>
					</div>
				</form>
			</div>
		</div>	
	</div>
	
	<!-- 게시물 목록 -->
	<div id="board-list">
		<div class="container">
			<table class="board-table" border=1 style="length:800px;">
				<thead>
				<tr>
					<th>NO</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회</th>
					<th>날짜</th>			
				</tr>
				</thead>
				<tbody>
				
				<%for(BoardVo bv : alist) {%>
			<tr>
				<td><%=bv.getBidx() %></td>
				<td class="title"><a><%=bv.getSubject() %></a></td>
				<td><%=bv.getWriter() %></td>
				<td><%=bv.getViewcnt() %></td>
				<td><%=bv.getWriteday() %></td>
			</tr>
			<%} %>
			
			</tbody>
		
			</table>
			<div class="btnBox">
				<a class="btn aBtn" href="<%=request.getContextPath() %>/board/boardWrite.aws">글쓰기</a>
			</div>
			<div class="page">
				<ul>
				<%if (pm.isPrev() == true) {%>
				<li><a href="<%=request.getContextPath() %>/board/boardList.aws?page=<%=pm.getStartPage()-1%>">◀</a></li>
				<%} %>
				<%for(int i = pm.getStartPage(); i<= pm.getEndPage(); i++) {%>
				<li <%if(i==pm.getCri().getPage()) {%>class="on"<%} %>>
				<a href="<%=request.getContextPath() %>/board/boardList.aws?page=<%=i%>"><%=i %></a></li>
				<%} %>
					
				<%if(pm.isNext() == true && pm.getEndPage() > 0) {%>
				<li><a href="<%=request.getContextPath() %>/board/boardList.aws?page=<%=pm.getEndPage()+1%>">▶</a></li>
				<%} %>
					
				</ul>
			
			</div>

		</div>
		
	</div>

</section>


</body>
</html>