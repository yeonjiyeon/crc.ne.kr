<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CRC.ne.kr</title>
</head>
<body class="w3-content">
 <form method="post" name="editForm" action="/editPro.do" onSubmit="return modifyCheckIt()">
   <table  class="c w3-card-4">
     <tr class="w3-card-4">
       <td colspan="2"><h1><b>회원정보수정</b></h1></td>       
     </tr>
     <tr>
       <td class="cent">ID</td>
       <td><input type="text" id="id" name="id" size="15" value="${memberDTO_session.id}" readonly></td>
     </tr>
     <tr>
       <td class="cent">암호</td>
       <td><input type="password" id="pwd" name="pwd" size="15" value="${memberDTO_session.pwd}"></td>
     </tr>
     <tr>
       <td class="cent">이름</td>
       <td><input type="text" id="name" name="name" size="20" value="${memberDTO.name}"></td>
     </tr>
     <tr>
       <td class="cent">이메일</td>
       <td><input type="text" id="email" name="email" size="20" value="${memberDTO.email}"></td>
     </tr>
     
   
   <tr class="c w3-card-4">
     <td colspan="2" class="cent w3-card-4">
       <input type="submit" value="회원정보수정" class="button button3 w3-card-4">
       <input type="reset" value="취소" class="button button2 w3-card-4" onClick="location='/myPage.do'">
     </td>
   </tr>
   </table>
 </form>

</body>
</html>