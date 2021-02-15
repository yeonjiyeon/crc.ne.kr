<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>CRC.ne.kr</title>
</head>
<body class="w3-content" style="max-width:960px">
<table width="100%">
  <tr>
	<td height="60" align="center">
		<tiles:insertAttribute name="header"/><!-- header.jsp -->
	</td>
  </tr>
  <tr>
	<td valign="top">
		<tiles:insertAttribute name="content"/><!-- 중앙에 표시 -->
	</td>
  <tr>
	<td height="0" align="center">
		<tiles:insertAttribute name="footer"/><!--footer.jsp -->
	</td>
  </tr>
</table>
</body>
</html>