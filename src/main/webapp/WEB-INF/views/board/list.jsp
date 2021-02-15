<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title><c:out value="${b_name2}"/></title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src='https://kit.fontawesome.com/a076d05399.js'></script>
  <!--Get your own code at fontawesome.com-->
</head>
<body class="w3-content">
<input type="hidden" name="id" size="20" value="${memberDTO_session.id}">

   <table class="w3-card-4">
     <tr class="w3-card-4">
       <td colspan="2">
        <h1> &nbsp;&nbsp;<a href="/${b_name}/list.do?pageNum=${pageNum}"><b><c:out value="${b_name2}"/></b></a></h1>
       </td>
     </tr>
     
     <tr>
       <td>  
		<div class="w3-row">
			<div class="w3-col s4 search-container" style="width:60%">			
			  <form method="post" action="/${b_name}/list.do" onsubmit="return checkserch()">
			    <input type="text" placeholder="Search..." id="keyword" name="keyword" size="10" value="${keyword}">
			    <input type="hidden" id="serch_check" value="${serch_type}">
			    <button type="submit"><i class="fa fa-search" style='font-size:16px;color:gray;'></i></button>			    
					<select id="serch_type" name="serch_type">
						<option value="all">제목+내용+글쓴이</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="id">글쓴이</option>						
					</select>			      
			    </form>
			</div>
			<div class="w3-col s4" style="width:40%;text-align:right;" >
			글갯수 <span class="w3-badge w3-black">${count}</span>               	
			    <!-- 로그인 상태시만 보이는 버튼------------------------------------------------>
				<c:if test="${!empty memberDTO_session.id}">
			   	<a href="/writeForm.do?b_name=${b_name}&pageNum=${pageNum}" class="button button1 w3-card-4">글쓰기</a>
			    </c:if>
			    <!-- 로그인 상태시만 보이는 버튼------------------------------------------------>			
			</div>
		</div>	
        </td>
      </tr>


       <td>
     <c:if test="${count==0 }">
      	저장된 글이 없습니다
     </c:if>
     
     <c:if test="${count>0 }">
      <table class="w3-animate-bottom">
       <tr class="w3-card-4">
         <td class="hidden1 cent" width="60px">번호</td>
         <td class="cent">제목</td>
         <td class="hidden1 cent" width="90px">글쓴이</td>
         <td class="hidden cent">날짜</td>
         <td class="cent" width="60px">조회</td>
        </tr>
        
        <c:forEach var="dto" items="${list}">
           <tr>
             <td class="hidden1 cent">
               <c:out value="${number}"/>
               <c:set var="number" value="${number-1}"/>
             </td>
             
             
             <td>
             <c:if test="${dto.re_level>0}">
               <img src="/resources/imgs/level.gif" width="${5*dto.re_level}" height="16">
               <img src="/resources/imgs/re5.png" width="18" height="18">
             </c:if>
             
             <c:if test="${dto.re_level==0}">
               <img src="/resources/imgs/level.gif" width="${5*dto.re_level}" height="16">
             </c:if>
             
             <a href="/<c:out value="${b_name}"/>/content.do?no=${dto.no}&pageNum=${pageNum}">${dto.subject}</a>
             <c:if test="${dto.hit>=20 }">
               <img src="/resources/imgs/hot2.png" border="0" width="16" height="16">
             </c:if>
             
             <c:if test="${dto.commentCount > 0}">
			  	<span style="font-size:12px; color:#353535;">[${dto.commentCount}]</span>
			  </c:if>
             
             
             </td>
             
             <td class="hidden1 cent">             
				${dto.id}
             </td>
             
             
             <td class="hidden cent">
               <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
             </td>
             
             <td class="cent"> ${dto.hit}</td>
           </tr>
        </c:forEach>
      </table>
    
     </c:if>
     </td>
    </tr>
     
	<tr class="w3-card-4">
	<td class="cent">
	 <c:if test="${count>0 }">
	     
	     <%--이전페이지 --%>
	     <c:if test="${startPage > 10 }">
				<a href="/<c:out value="${b_name}"/>/list.do?pageNum=${startPage-10}">[이전]</a>
		 </c:if>
	     
	     <%--페이지처리 --%>
	    <c:forEach var="i" begin="${startPage}"  end="${endPage}">
	      <a href="/<c:out value="${b_name}"/>/list.do?pageNum=${i}">[${i}]</a>
	    </c:forEach>
	    
	    <%--다음 페이지 --%>
	    <c:if test="${endPage < pageCount }">
			<a href="/<c:out value="${b_name}"/>/list.do?pageNum=${startPage+10}">[다음]</a>
		</c:if>
	    
	    
	 </c:if>
	</td>
	</tr>
	    
     
   </table>
   
   <script>
$(document).ready(function(){
	var serch_check = $("#serch_check").val();
	if(serch_check == ""){
		
	}else{
		$('#serch_type').val(serch_check);	
		
	}
	
});

function checkserch(){
	
	if($("#keyword").val() == ""){
		alert("검색어를 입력하세요");
		$("#keyword").focus();
		return false;
	}
	
}

</script>
</body>
</html>