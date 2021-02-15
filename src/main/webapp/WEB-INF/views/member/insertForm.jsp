<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CRC.ne.kr</title>
</head>
<body class="w3-content">
<form method="post" name="writeForm" action="/insertPro.do" 
onSubmit="return check()">
<table class="c w3-card-4">
  <tr class="w3-card-4">
    <td colspan="2"><h1><b>회원가입</b></h1></td>       
  </tr>
	 
  <tr>
    <td class="cent">ID</td>
    <td>
    <input type="text" id="id" name="id" size="10"/>
    <input type="button" id="btn" value="id중복체크" onClick="idCheck()">
     </td>
  </tr>
     
  <tr>
     <td class="cent">암호</td>
     <td><input type="password" id="pwd" name="pwd" size="15"/></td>
  </tr>
  
  <tr>
     <td class="cent">암호확인</td>
     <td><input type="password" id="pwd2" name="pwd2" size="15"/></td>
  </tr>
  
  <tr>
    <td class="cent">이름</td>
    <td><input type="text" id="name" name="name" size="20"/></td>
  </tr>
     
 <tr>
   <td class="cent">Email</td>
   <td><input type="text" id="email" name="email" size="20"/></td>
 </tr>

  <tr class="w3-card-4">
    <td colspan="2" class="cent">
	  <input type="submit" value="회원가입" class="button button3 w3-card-4">
	  <input type="reset" value="다시입력" class="button button2 w3-card-4">
	  <input type="button" value="가입안함" class="button button2 w3-card-4" onClick="location='/'">
    </td>
  </tr>
</table>
</form>
</body>
</html>