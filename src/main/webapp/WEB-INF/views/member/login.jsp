<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>CRC.ne.kr</title>
</head>
<body class="w3-content">
 <form method="post" name="login"  action="/loginPro.do" onSubmit="return logincheck()"> 
   <table class="login w3-card-4">
     <tr class="w3-card-4">
       <td colspan="2"><h1><b>로그인</b></h1></td>       
     </tr>
     
     <tr>
       <td class="cent">ID</td>
       <td><input type="text" id="id" name="id" size="15"></td>
     </tr>
     <tr>
       <td class="cent">암호</td>
       <td><input type="password" id="pwd" name="pwd" size="15"></td>
     </tr>
     
     <tr class="w3-card-4"> 
       <td colspan="2" align="center">       
         <input type="submit" value="전송" class="button button2 w3-card-4">
         <input type="reset" value="취소" class="button button2 w3-card-4">
         <a href="/insertForm.do" class="button button3 w3-card-4"><font color="white">회원가입</font></a>
       </td>
     </tr>
   </table>
 </form>

</body>
</html>
