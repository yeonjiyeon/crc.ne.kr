<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>CRC.ne.kr</title>
  <script type="text/javascript">
  function updateUser(){
	  document.updateForm.action="editForm.do";//회원정보수정
	  document.updateForm.submit();
  }
  
  function deleteUser(){
	  document.deleteForm.action="memberDelete.do";//회원탈퇴
	  document.deleteForm.submit();
  }
  </script>
</head>
<body class="w3-content">

<table class="c w3-card-4">
    <tr class="c w3-card-4">
      <td>
		<h3>[<font color="darkgoldenrod"><b>${memberDTO_session.name}</b></font>] 님</h3>		
		<!-- EL,JSTL -->
		<%
		//session.setAttribute("id", memberDTO.id);
		%>
      </td>
      <td class="right">
        <font color="orange" size="6"><b>myPage</b></font><img alt="MyPage" src="/resources/imgs/myico_b.png" width="50" height="50">       
      </td>
    </tr>
    <tr>
      <td colspan="2">&nbsp;&nbsp;<b>저희 홈에 오신 것을 환영 합니다!</b></td>
    </tr>
    <tr>
      <td colspan="2" class="mmenu">
        <b>C</b>ontent <br>
        <b>R</b>eview <br>
        <b>C</b>ommunity <br>
      </td>
    </tr>    
     <tr>
       <td class="cent">이름</td>
       <td>${memberDTO_session.name}</td>
     </tr>    
     <tr>
       <td class="cent">ID</td>
       <td>${memberDTO_session.id}</td>
     </tr>
     <tr>
       <td class="cent">이메일</td>
       <td>${memberDTO_session.email}</td>
     </tr>  
<c:set var="id" value="${memberDTO_session.id}" scope="session"/>
    <tr class="c w3-card-4">
      <td class="cent w3-card-4" colspan="2">
		<a href="javaScript:updateUser()" class="button button2 w3-card-4"><font color="white">회원정보수정</font></a>
		<a href="javaScript:deleteUser()" class="button button2 w3-card-4"><font color="white">회원탈퇴</font></a>
      </td>
    </tr>
</table>
<form name="updateForm" method="post">
  <input type="hidden" name="id" id="id" value="${id}">
</form>

<form name="deleteForm" method="post">
  <input type="hidden" name="id" id="id" value="${id}">
</form>
</body>
</html>