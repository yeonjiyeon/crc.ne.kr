<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><c:out value="${b_name2}"/></title>
</head>
<body class="w3-content">
  <form method="post" name="writeForm" action="/updatePro.do?pageNum=${pageNum}&b_name=${b_name}">
  
  <table class="w3-card-4">
  	 <tr>
      <td colspan="2">
        <h1> &nbsp;&nbsp;<a href="/${b_name}/list.do?pageNum=${pageNum}"><b><c:out value="${b_name2}"/></b></a></h1>      
      </td>
     </tr>
     
     <tr class="w3-card-4">  
      <td colspan="2"><h5><b>${dto.subject}</b></h5></td>      
    </tr>
    
     <tr>       
       <td colspan="2">
         <input type="text" name="subject" id="subject" size="40" value="${dto.subject}">
         <input type="hidden" name="no" value="${dto.no}">
         <input type="hidden" name="id" size="20" value="${memberDTO_session.id}">
       </td>
     </tr>
     
     <tr>
       <td colspan="2">
       <textarea name="content" id="content" rows="15" wrap="hard">${dto.content}</textarea>
       </td>
     </tr>
    
	<tr>
	  <td colspan="2" class="cent">
	<!-- 로그인 상태시 보이는 버튼------------------------------------------------>
	<c:if test="${!empty memberDTO_session.id}">
     	<input type="submit" value="수정" class="button button2 w3-card-4">
	    <input type="reset" value="다시작성" class="button button2 w3-card-4">
	    <input type="button" value="목록" class="button button3 w3-card-4"
	     onclick="document.location.href='/${b_name}/list.do?pageNum=${pageNum}'">       	    
	</c:if>
	<!-- 로그인 상태시 보이는 버튼------------------------------------------------>

	<!-- 로그아웃 상태시만 보이는 버튼------------------------------------------------>
	<c:if test="${empty memberDTO_session.id}">
		<input type="button" value="목록" class="button button3 w3-card-4"
	     onclick="document.location.href='/${b_name}/list.do?pageNum=${pageNum}'">
	</c:if>
	<!-- 로그아웃 상태시만 보이는 버튼------------------------------------------------>  	  
	  
	  </td>
	</tr>
  </table>
  </form>
</body>
</html>