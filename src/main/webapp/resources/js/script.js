//회원가입/수정시 DAUM 우편번호/주소 API 체크
/*
function openDaumPostcode(){
	new daum.Postcode({
		oncomplete:function(data){
			document.getElementById('zipcode').value=data.zonecode;
			document.getElementById('addr').value=data.address;
 		}
	}).open();
}//openDaumPostcode()---
*/

//멤버 로그인 화면에서 회원 로그인 체크
function logincheck(){
	if($('#id').val()==''){
		alert("ID 를 입력 하시요");
		$('#id').focus();
		return false;
	}
	
	if($('#pwd').val()==''){
		alert("암호 를 입력 하시요");
		$('#pwd').focus();
		return false;
	}
	 return true;
}//logincheck() end

//회원가입시 체크사항
function check(){
	 
	if($('#id').val()==''){
		alert("ID 를 입력 하시요");
		$('#id').focus();
		return false;
	}
	
	if($('#pwd').val()==''){
		alert("암호 를 입력 하시요");
		$('#pwd').focus();
		return false;
	}
	if($('#pwd2').val()==''){
		alert("암호확인 를 입력 하시요");
		$('#pwd2').focus();
		return false;
	}
	
	if($('#pwd').val() != $('#pwd2').val()){
		alert("암호와 암호확인 일치하지 않습니다");
		
		$('#pwd').val('').focus();
		$('#pwd2').val('');
		return false;
	}
	
	if($('#name').val()==''){
		alert("이름을 입력 하시요");
		$('#name').focus();
		return false;
	}
	/*if($('#idcheck').val()=="-1"){
		alert("ID중복 체크를 하시요");
		$('#id').focus();
		return false;
	}*/
	return true;
}//check() end


//------------------------
//ajax 이용하여 id사용 여부 체크 
//------------------------

	function idCheck() {
		//alert("idCheck");
		if($('#id').val()==''){
			alert("id를 입력 하시요");
			$('#id').focus();
		}else{//id가 입력이 되었을때 
			$.ajax({
				type:"POST",
				url:"idCheck.do",
				data:"id="+$('#id').val(),
				dataType:'JSON',
				success:function(data){
					if(data.check==1){
						alert("사용 가능한 id 입니다");
						$("#pwd").focus();
					}else{
						alert("사용중인 id 입니다");
						$('#id').val("").focus();
					}
				}//success:function end
			});//ajax end
			
		}//else end
	}//idCheck() end


//회원가입시 ID 중복체크 포커스 이벤트
//function onfocus_id(){
//  /* onfocus 이벤트 */
//	if($('#idCheck').val()=='-1'){
//		alert("[ID중복체크]를 하시요");
//		$('#id').focus();
//		return false;
//	}
//  return true;


//회원정보수정시 modifyForm에서 체크
function modifyCheckIt(){
	  var inputForm = eval("document.editForm");//userInput 폼이롬
	  
	  if(!editForm.pwd.value){
		  alert("[비밀번호]를 입력하세요");
		  editForm.pwd.focus();
		  return false;
	  }
  
	  if(!editForm.name.value){
		  alert("[이름]을 입력하세요");
		  editForm.name.focus();
		  return false;
	  }
	  
	  if(!editForm.email.value){
		  alert("[이메일]을 입력하세요");
		  editForm.email.focus();
		  return false;
	  }
	  return true; 
}//modifyCheckIt() end

//게시판 Board 글쓰기 writeForm에서 체크
//로그인상태에서 체크
function writeSave(){
	   
//	   if($("#name").val()==''){
//	   alert("[이름]을 입력 하시요 ");
//	   $("#name").focus();
//		   return false;
//	   }
	   
	   if($("#subject").val()==''){
	   alert("[제목]을 입력 하시요 ");
	   $("#subject").focus();
		   return false;
	   }
	   
//	   if($("#email").val()==''){
//		   alert("[이메일]을 입력 하시요 ");
//		   $("#email").focus();
//			   return false;
//	   }
	   
	   if($("#content").val()==''){
	   alert("[글내용]을 입력 하시요 ");
	   $("#content").focus();
		   return false;
	   }
	   
//	   if($("#pwd").val()==''){
//	   alert("[암호]을 입력 하시요 ");
//	   $("#pwd").focus();
//			return false;
//	   }
	   
	return true;
}//writeSave() end

/* 햄버거 버튼  스크립트 시작 */
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
/* 햄버거 버튼  스크립트 끝 */
