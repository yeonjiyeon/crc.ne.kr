<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>CRC.ne.kr</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">	
	<link rel="stylesheet" href="/resources/css/w3.css">
	<link rel="stylesheet" href="/resources/css/bcr.css">
	<script  src="//code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="/resources/js/script.js"></script>	
</head>
<body class="w3-content" style="max-width:960px">
<!-- 햄버거 버튼 사이드 패널 시작 --------------------------------------------->
<div id="mySidenav" class="sidenav">

<table class="menu w3-card-4">
  <tr>
    <td class="right"><img src="/resources/imgs/member.png" width="40" height="40"></td>
    <td class="cent">   
		<!-- 로그아웃 상태시 보이는 버튼------------------------------------------------>
		<c:if test="${empty memberDTO_session.id}">
		<a href="/login.do"><font color="white">로그인 &<br>회원가입</font></a>
		</c:if>
		<!-- 로그인 상태시 보이는 버튼------------------------------------------------>		
		<c:if test="${!empty memberDTO_session.id}">
		<a href="/myPage.do"><img alt="MyPage" src="/resources/imgs/myico_.png"><font color="orange" size="3">myPage</font></a> 
		<a href="/logOut.do"><font color="white">로그아웃</font></a>    
		</c:if>
    </td>
  </tr>
</table>
<table>
  <tr>
    <td>
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"><img src="/resources/imgs/xbtn2.png" width="24" height="24"></a> 
	  <a href="/drama/list.do">드라마</a>
	  <a href="/movie/list.do">영화</a>
	  <a href="/kpop/list.do">K팝</a>
	  <a href="/pop89/list.do">팝8090</a>
	  <a href="/fashion/list.do">패션</a>
	  <a href="/exhibition/list.do">전시회</a>
	  <a href="/book/list.do">책</a>
	  <a href="/board/list.do">자유게시판</a>
    </td>
  </tr>
</table>
</div>
<!-- 햄버거 버튼 사이드 패널 끝 ----------------------------------------------->

<!-- header 시작 ----------------------------------------------------------->
<div class="header">
  <ul class="nav">
	<li>
	<!-- 햄버거 버튼  ------------------------------------------------------------->
	<span style="font-size:30px;font-color:white;cursor:pointer" onclick="openNav()"><img src="/resources/imgs/hammenu3.png" width="36" height="36"></span>
	<!-- 햄버거 버튼  ------------------------------------------------------------->
	</li>
	<li><a href="/"><font color="white" size="6"><b> CRC.ne.kr </b></font></a></li>
	<li class="hidden">&nbsp;&nbsp;</li>
	<li class="hidden"><a href="/drama/list.do" class="hidden"> 드라마 </a></li>
	<li class="hidden"><a href="/movie/list.do" class="hidden"> 영화 </a></li>
	<li class="hidden"><a href="/kpop/list.do" class="hidden"> K팝 </a></li>
	<li class="hidden"><a href="/pop89/list.do" class="hidden"> 팝8090 </a></li>
	<li class="hidden"><a href="/fashion/list.do" class="hidden"> 패션 </a></li>
	<li class="hidden"><a href="/exhibition/list.do" class="hidden"> 전시회 </a></li>
	<li class="hidden"><a href="/book/list.do" class="hidden"> 책 </a></li>
	<li class="hidden3"><a href="/board/list.do" class="hidden3"> 자유게시판 </a></li>
	<li class="hidden">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
	<li class="hidden1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
	<li class="hidden2">&nbsp;&nbsp;</li>
	<li class="hidden3">&nbsp;&nbsp;</li>

	<!-- 로그아웃 상태시 보이는 버튼------------------------------------------------>
	<c:if test="${empty memberDTO_session.id}">	
	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
	<li>
	  <a href="/login.do" class="btn"><font color="white">로그인</font></a>
	</li>
	</c:if>
		
	<!-- 로그인 상태시 보이는 버튼------------------------------------------------>
	<c:if test="${!empty memberDTO_session.id}">
	<li><a href="/myPage.do"><img alt="MyPage" src="/resources/imgs/myico.png"></a> 
	    <a href="/logOut.do" class="btn"><font color="white">로그아웃</font></a></li>
	</c:if>
	
  </ul>
</div>
<!-- header 끝 ----------------------------------------------------------->


<!-- main 시작 ----------------------------------------------------------->
<table height="61">
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<c:forEach var="comment" items="${drama_comment }">
	${comment}
</c:forEach>
<div class="main w3-row-padding">

	<div class="w3-half gallery w3-card-4 w3-animate-left">
	  <div class="a"><h4><a href="/drama/list.do"><b>드라마</b></a></h4></div>	  
		<c:forEach var="content" items="${drama}">
		  <table>
		    <tr>
			  <td><a href="/drama/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  <c:if test="${content.commentCount > 0}"> <!-- 댓글 0 개이면 출력 안되게 -->
			  	${content.commentCount} <!-- 댓글 1 개부터 출력 -->
			  </c:if>
			  </font></p></a>
			  </td>				    	
			</tr>
		  </table>
		</c:forEach>
	</div>
			
	<div class="w3-half gallery w3-card-4 w3-animate-right">
	  <div class="a"><h4><a href="/movie/list.do"><b>영화</b></a></h4></div>
		<c:forEach var="content" items="${movie}">
		  <table>
		    <tr>
			  <td><a href="/movie/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  	<c:if test="${content.commentCount > 0}">
			  	${content.commentCount}
			  </c:if>
			  </font></p></a>
			  </td>
			</tr>
		  </table>
		</c:forEach>
	</div>
		
	<div class="w3-half gallery w3-card-4 w3-animate-left">
	  <div class="a"><h4><a href="/kpop/list.do"><b>K팝</b></a></h4></div>
		<c:forEach var="content" items="${kpop}">
		  <table>
		    <tr>
			  <td><a href="/kpop/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  	<c:if test="${content.commentCount > 0}">
			  	${content.commentCount}
			  </c:if>
			  </font></p></a>
			  </td>
			</tr>
		  </table>
		</c:forEach>
	</div>
				
	<div class="w3-half gallery w3-card-4 w3-animate-right">
	  <div class="a"><h4><a href="/pop89/list.do"><b>팝8090</b></a></h4></div>
		<c:forEach var="content" items="${pop89}">
		  <table>
		    <tr>
			  <td><a href="/pop89/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  	<c:if test="${content.commentCount > 0}">
			  	${content.commentCount}
			  </c:if>
			  </font></p></a>
			  </td>			
			</tr>
		  </table>
		</c:forEach>
	</div>
				
	<div class="w3-half gallery w3-card-4 w3-animate-left">
	  <div class="a"><h4><a href="/fashion/list.do"><b>패션</b></a></h4></div>
		<c:forEach var="content" items="${fashion}">
		  <table>
		    <tr>
			  <td><a href="/fashion/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  	<c:if test="${content.commentCount > 0}">
			  	${content.commentCount}
			  	</c:if>
			  </font></p></a>
			  </td>				    				  
			</tr>
		  </table>
		</c:forEach>
	</div>	

	<div class="w3-half gallery w3-card-4 w3-animate-right">
	  <div class="a"><h4><a href="/exhibition/list.do"><b>전시회</b></a></h4></div>
		<c:forEach var="content" items="${exhibition}">
		  <table>
		    <tr>
			  <td><a href="/exhibition/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  	<c:if test="${content.commentCount > 0}">
			  	${content.commentCount}
			  </c:if>
			  </font></p></a>
			  </td>				    				  
			</tr>
		  </table>
		</c:forEach>
	</div>

	<div class="w3-half gallery w3-card-4 w3-animate-left">
	  <div class="a"><h4><a href="/book/list.do"><b>책</b></a></h4></div>
		<c:forEach var="content" items="${book}">
		  <table>
		    <tr>
			  <td><a href="/book/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  	<c:if test="${content.commentCount > 0}">
			  	${content.commentCount}
			  </c:if>
			  </font></p></a>
			  </td>				    	
			</tr>
		  </table>
		</c:forEach>
	</div>
				
	<div class="w3-half gallery w3-card-4 w3-animate-right">
	  <div class="a"><h4><a href="/board/list.do"><b>자유게시판</b></a></h4></div>
		<c:forEach var="content" items="${board}">
		  <table>
		    <tr>
			  <td><a href="/board/content.do?no=${content.no}&pageNum=1"><p class="ellipsis">${content.subject}
			  <font class="mhit">
			  	<c:if test="${content.commentCount > 0}">
			  	${content.commentCount}
			  </c:if>
			  </font></p></a>
			  </td>				    	
			</tr>
		  </table>
		</c:forEach>
	</div>	
	
</div>

<table height="30">
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<!-- main 끝 ------------------------------------------------------------>


<!-- footer 시작 ----------------------------------------------------------->
<div class="footer">copyright ⓒ www.CRC.ne.kr</div> 
<!-- footer 끝 ------------------------------------------------------------>


<!-- 햄버거 버튼  스크립트 시작--------------------------------------------->
<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
<!-- 햄버거 버튼 사이드 패널 스크립트 끝--------------------------------------------->

</body>
</html>