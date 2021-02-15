<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><c:out value="${b_name2}"/></title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
.buttonx a:link , .buttonx a:visited , .buttonx a:hover , .buttonx a:active {font-size:12px; display:inline-block; color:#ffffff;text-align:center; line-height:18px; width:18px; height:18px; background-color:#999999; }
</style>
<body class="w3-content">

  <table class="w3-card-4">
    <tr>
      <td colspan="2">
        <h1> &nbsp;&nbsp;<a href="/${b_name}/list.do?pageNum=${pageNum}"><b><c:out value="${b_name2}"/></b></a></h1>
      </td>
    </tr>
    
    <tr class="w3-card-4">  
      <td width="80%"><h5><b>${dto.subject}</b></h5></td>
      <td width="20%" align="right">조회수 <span class="w3-badge w3-black">${dto.hit}</span></td>
    </tr>

    <tr>
      <td colspan="2">
      	   ${dto.id}
           <input type="hidden" name="id" size="20" value="${memberDTO_session.id}">           
           <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd hh:mm:ss"/>      
    </tr>
            
    <tr>
      <td colspan="2">        
        <!-- <textarea rows="20" wrap="hard" readOnly>${content}</textarea> -->
        <!-- html 소스 삽입 가능한 에디터로 대체 /but 키보드 엔터기능이 불가 <br>을 수동으로 입력해야 함  -->
      	<div id="editor" class="test_box" contenteditable="true"  style="white-space:pre;">${content}</div>
        <!-- style="white-space:pre;" 에디터에서 글쓸때 textarea에서 처럼 보이게 엔터시 <br> 자동붙게 하려고  -->
      </td>
    </tr>
    
    <tr class="w3-card-4">
    <td colspan="2" class="cent"> 
    <c:if test="${memberDTO_session.id==dto.id}">
      <input type="button" value="수정" class="button button2 w3-card-4"
       onclick="document.location.href='/updateForm.do?no=${dto.no}&pageNum=${pageNum}&b_name=${b_name}'">
      <input type="button" value="삭제" class="button button2 w3-card-4"
       onclick="document.location.href='/delete.do?b_name=${b_name}&no=${dto.no}&pageNum=${pageNum}'">
    </c:if>    
      	
	<!-- 로그인 상태시 보이는 버튼------------------------------------------------>
	<c:if test="${!empty memberDTO_session.id}">            
	    <input type="button" value="답글" class="button button2 w3-card-4"
	      onclick="document.location.href='/writeForm.do?b_name=${b_name}&no=${dto.no}&ref=${dto.ref}&re_step=${dto.re_step}&re_level=${dto.re_level}&pageNum=${pageNum}'">
	 
	 	<input type="button" value="글쓰기" class="button button2 w3-card-4"
	      onclick="document.location.href='/writeForm.do?b_name=${b_name}&pageNum=${pageNum}'">
	    
		<input type="button" value="목록"  class="button button3 w3-card-4"
		  onclick="document.location.href='/${b_name}/list.do?pageNum=${pageNum}'">
    	    
	</c:if>
	<!-- 로그인 상태시 보이는 버튼------------------------------------------------>

	<!-- 로그아웃 상태시만 보이는 버튼------------------------------------------------>
	<c:if test="${empty memberDTO_session.id}">
	<input type="button" value="목록"  class="button button3 w3-card-4"
    onclick="document.location.href='/${b_name}/list.do?pageNum=${pageNum}'">
	</c:if>
	<!-- 로그아웃 상태시만 보이는 버튼------------------------------------------------>	

    </td>
    </tr>
    <tr>
    	<td colspan="2" style="border:none; background-color:#ffffff;">
    		<div>총 댓글수 : ${count}</div>
    		<!-- 댓글 출력 -->
    		<c:forEach var="dto" items="${list_c}">
		    	<div style=" ">
		    		<c:if test="${dto.re_step == 0}">
		    		<div style="width:100%; overflow:hidden;  border-bottom:1px dotted #ddd; ">
			    		<div align="right" style="width:100%; color:#999999; padding:2px 0; font-size:12px; line-height:20px;">
			    		${dto.id} ${dto.regdate}
			    		</div>

			    		<div style="float:left; width:100%;">
				    		<div style="overflow:hidden; ">
					    		<div 
					    		<c:if test="${!empty memberDTO_session.id}">
					    	 	onclick="comment_insert(${dto.no_c},${comment_count})" 
					    		</c:if>
					    		style="cursor:pointer; float:left;  padding:2px 0; width:88%;">
					    			<div style="overflow:hidden;">
					    				${dto.content_c} 
					    			</div>
					    		</div>
					    		
					    		<div class="buttonx"  style="width:20px; padding:0 0; text-align:center; float:right;">
					    		<c:if test="${memberDTO_session.id == dto.id}">
					    		<a href="/${b_name}/comment_delete.do?no_c=${dto.no_c}&no=${dto.no}&pageNum=${pageNum}">x</a>
					    		</c:if>
					    		</div>
					    		
				    		</div>
				    		<c:if test="${memberDTO_session.id == dto.id}">
					    	<div style="text-align:right; width:100%;"><a href="javascript:modi(${dto.no_c},${comment_count})"><span style="color:#499292;" id="modi_v${dto2.no_c}">수정</span></a></div>			
					    	</c:if>
				    		<!-- 대댓글 입력폼 -->
				    		<div id="comins_${dto.no_c}" style="display:none; overflow:hidden; width:100%;">
				    			<form method="post" name="comment_c" action="/${b_name}/comment.do">
				    				<input name="no" type="hidden" value="${dto.no}">
				    				<input name="id" type="hidden" value="${memberDTO_session.id}">
				    				<input name="pageNum" type="hidden" value="${pageNum}">
				    				<input name="ref" type="hidden" value="${dto.no_c} ">
				    				<div style="width:80%; float:left;">
				    					<textarea name="content_c"></textarea>
				    				</div>
				    				<div style="width:20%; float:left; padding-left:2%;">
				    					<input style="width:100%; height:74px;" type="submit" value="등록">
				    				</div>
				    			</form>
				    		</div>
				    		<!-- 대댓글 입력폼 -->
				    		<!-- 댓글수정폼 -->
				    		<div id="modi_${dto.no_c}" style="display:none; overflow:hidden;width:100%;">
				    			<form method="post" name="comment_modi" action="/${b_name}/comment_modi.do">
				    				<input type="hidden" name="no_c" value="${dto.no_c}">
				    				<input type="hidden" name="no" value="${dto.no}">
				    				<input name="pageNum" type="hidden" value="${pageNum}">
				    				<div style="width:80%; float:left;">
				    					<textarea name="content_c">${dto.content_c}</textarea>
				    				</div>
				    				<div style="width:20%; float:left; padding-left:2%;">
				    					<input style="width:100%; height:74px;" type="submit" value="수정">
				    				</div>
				    			</form>
				    		</div>
				    		<!-- 댓글수정폼 -->
			    		</div> 		
		    		</div>
		    		</c:if>
		    		<!-- 대댓글 출력 -->
		    		 <div style="width:97%;    margin-left:3%; ">
				    	<c:if test="${dto.re_step > 0}">	
				   
				    	<div style="width:100%;  overflow:hidden;  padding-top:4px;   background-color:#F4F4F4;  border:1px solid #ddd; border-top:none;">
				    		<div style="overflow:hidden">
				    		<div style="float:left; width:100%; color:#999999; padding:2px 0; font-size:12px; line-height:14px;">└${dto.id} ${dto.regdate}</div>
				    		<div style="width:100%; float:left;">
				    			<div style="overflow:hidden">
				    				<div style="float:left; width:85%">${dto.content_c}</div>	
				    				<div class="buttonx"  style="width:20px; text-align:center; float:right;">
						    		<c:if test="${memberDTO_session.id == dto.id}">
						    			<a href="/${b_name}/comment_delete.do?no_c=${dto.no_c}&no=${dto.no}&pageNum=${pageNum}">x</a>
						    		</c:if>
						    		</div>
				    			</div>
				    		</div>
				    		</div>
				    		<c:if test="${memberDTO_session.id == dto.id}">
					    	<div style="width:100%; text-align:right;"><a href="javascript:modi_c(${dto.no_c},${comment_count})" ><span style="color:#499292;" id="modi_c${dto2.no_c}">수정</span></a></div>			
					    	</c:if>
				    	</div>
				    	<!-- 대댓글 수정폼 -->
				    	<div id="modi2_${dto.no_c}" style="display:none;">
					    	<form method="post" name="comment_modi" action="/${b_name}/comment_modi.do">
			    				<input type="hidden" name="no_c" value="${dto.no_c}">
			    				<input type="hidden" name="no" value="${dto.no}">
			    				<input name="pageNum" type="hidden" value="${pageNum}">
			    				<div style="width:80%; float:left;">
			    					<textarea name="content_c">${dto.content_c}</textarea>
			    				</div>
			    				<div style="width:20%; float:left; padding-left:2%;">
			    					<input style="width:100%; height:74px;" type="submit" value="수정">
			    				</div>
			    			</form>
		    			</div>
		    			
		    			<!-- 대댓글 수정폼 -->
			    		</c:if>
			    	</div>
			    	
			    	</div>
			</c:forEach>
				    
				    <!-- 대댓글 출력 -->
		    	
		    	
	    	
    	</td>
    </tr>
    <!-- 댓글입력 폼 -->
    <tr class="w3-card-4">
	<td colspan="2">
	<div style="width:100%; text-align:center;">
	 <c:if test="${count>0 }">
	     
	     <%--이전페이지 --%>
	     <c:if test="${startPage > 10 }">
				<a href="/<c:out value="${b_name}"/>/content.do?no=${dto.no}&pageNum=${pageNum}&CommentNum=${startPage-10}">[이전]</a>
		 </c:if>
	     
	     <%--페이지처리 --%>
	    <c:forEach var="i" begin="${startPage}"  end="${endPage}">
	      <a href="/<c:out value="${b_name}"/>/content.do?no=${dto.no}&pageNum=${pageNum}&CommentNum=${i}">[${i}]</a>
	    </c:forEach>
	    
	    <%--다음 페이지 --%>
	    <c:if test="${endPage < pageCount }">
			<a href="/<c:out value="${b_name}"/>/content.do?no=${dto.no}&pageNum=${pageNum}&CommentNum=${startPage+10}">[다음]</a>
		</c:if>
	    
	    
	 </c:if>
	 </div>
	</td>
	</tr>
   
    <c:if test="${!empty memberDTO_session.id}">
    <tr>
    	<td colspan="2" >
	    	<form method="post" name="comment" action="/${b_name}/comment.do" >
	    		<input name="no" type="hidden" value="${dto.no}">
	    		<input name="id" type="hidden" value="${memberDTO_session.id}">
	    		<input name="pageNum" type="hidden" value="${pageNum}">
	    		<input name = "ref" type="hidden" value="0">
	    		<div style="width:100%;  overflow:hidden;">
	    			<div style="float:left;width:80%;">
	    			<textarea style="width:100%;" name="content_c" rows="" cols=""></textarea>
	    			</div>
	    			<div style="float:right; padding-left:2%; width:20%;">
	    			<input style="width:100%; height:74px;" type="submit" value="등록">
	    			</div>
	    		</div>
	    	</form>
    	</td>    	
    </tr>
    </c:if>
    <!-- 댓글입력 폼 끝 -->

  </table>
  
  
  <script>
function modi_c(modi2_num,num){
	  
	  //alert(modi2_num);
	  if($("#modi2_"+modi2_num).css("display") == "none"){
		  
		  jQuery("#modi2_"+modi2_num).show();  
		  $("#modi_c"+modi2_num).html("취소");
		  
		  for(var i = 1; i<= num; i++){
			  if(i == modi2_num){
				  
			  }else{
				  jQuery("#modi2_"+i).hide();
				  $("#modi_c"+i).html("수정");
				  jQuery("#comins_"+i).hide();
				  $("#modi_v"+i).html("수정");
				  jQuery("#modi_"+i).hide();
			  }
		  }
		  
		  
	  }else{
		  $("#modi_c"+modi2_num).html("수정");
		  jQuery("#modi2_"+modi2_num).hide();
		  
	  }
  }
  function comment_insert(com_ins,num){
	  if($("#comins_"+com_ins).css("display") == "none"){
		  jQuery("#comins_"+com_ins).show();
		  
		  for(var i = 1; i<= num; i++){
			  if(i == com_ins){
				  
			  }else{
				  jQuery("#modi2_"+i).hide();
				  $("#modi_c"+i).html("수정");
				  jQuery("#comins_"+i).hide();
				  $("#modi_v"+i).html("수정");
				  jQuery("#modi_"+i).hide();
			  }
		  }
	  }else{

		  jQuery("#comins_"+com_ins).hide();
		  
	  }
	  
  }
function modi(modi_num,num){
	  
	  if($("#modi_"+modi_num).css("display") == "none"){
		  jQuery("#modi_"+modi_num).show();
		  
		  $("#modi_v"+modi_num).html("취소");	
		  
		  for(var i = 1; i<= num; i++){
			  if(i == modi_num){
				  
			  }else{
				  jQuery("#modi2_"+i).hide();
				  $("#modi_c"+i).html("수정");
				  jQuery("#comins_"+i).hide();
				  $("#modi_v"+i).html("수정");
				  jQuery("#modi_"+i).hide();
			  }
		  }
	  }else{
		  $("#modi_v"+modi_num).html("수정");
		  jQuery("#modi_"+modi_num).hide();
		  
	  }
	  
  }
$(document).ready(function(){
	  $("#editor").on("keypress", function(e) {
	      e.preventDefault();
	  });
	 
	});
</script>
</body>
</html>