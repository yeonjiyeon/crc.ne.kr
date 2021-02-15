package org.bcr.controller;
import java.io.IOException;
import java.util.HashMap;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.bcr.model.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class MemberController {
	@Autowired
	private SqlSession sqlSession;
	
	//회원가입폼으로 
	@RequestMapping("/insertForm.do")
	public String insertForm() {
		//return "/member/insertForm";//뷰 리턴, insertForm.jsp 
		return ".main.member.insertForm";//뷰 리턴, insertForm.jsp
	}
	 
	
	
	//id중복 체크 
	@RequestMapping(value="/idCheck.do", method=RequestMethod.POST)
	public String idCheck(String id,Model model) {
		int check=-1;//사용중
		MemberDTO memberDTO=sqlSession.selectOne("member.selectOne",id);
		
		
		if(memberDTO==null) {
			check=1;//사용 가능한 id
		}
		System.out.println("memberDTO.id  check:"+check);
		
		model.addAttribute("check",check);
		//                  key,value
		return "/member/idCheck";//뷰 리턴, idCheck.jsp 요걸로 해야함
		//return ".main.member.idCheck";//뷰
	}//method end
	 
	
	
	//회원가입
	@RequestMapping(value="/insertPro.do",method=RequestMethod.POST)
	public String memberInsert(@ModelAttribute("memberDTO") MemberDTO memberDTO)
	throws NamingException,IOException{
		
		sqlSession.insert("member.insertMember",memberDTO);
		//return "/member/login";//뷰이름 login.jsp
		return ".main.member.login";//뷰
		//return "main";//뷰이름    main.jsp실행  
	}//method end

	//로그인 폼
	@RequestMapping("/login.do")
	public String loginform() {
		//return "/member/login";//뷰이름
		return ".main.member.login";//뷰
	}

	//로그인
	@RequestMapping(value="/loginPro.do",method=RequestMethod.POST)
	public String userLogin(String id,String pwd,Model model,HttpServletRequest request) 
			throws NamingException,IOException
	{
		HashMap <String,String>map =new HashMap<String,String>();
		map.put("id",id);
		map.put("pwd",pwd);
		
		MemberDTO memberDTO=sqlSession.selectOne("member.selectLogin",map);
		if(memberDTO==null) {//로그인 실패
			model.addAttribute("msg","로그인 실패");
			//return "/member/login";//뷰이름
			return ".main.member.login";//뷰
		}
		//model.addAttribute("memberDTO",memberDTO);
		request.getSession().setAttribute("memberDTO_session",memberDTO);
		//return "/member/loginSuccess";//뷰이름 
		return ".main.member.loginSuccess";//뷰
		
	}//userLogin() end
	
	
	//로그아웃
	@RequestMapping("/logOut.do")
	public String userOut() {
		//return "/member/logOut";//뷰이름
		return ".main.member.logOut";//뷰
	}

	
	//마이 페이지
	@RequestMapping("/myPage.do")
	public String myPage() {
		//return "/member/loginSuccess";//뷰 리턴, loginSuccess.jsp 
		return ".main.member.loginSuccess";//뷰 리턴, loginSuccess.jsp
	}
		 
	
	//회원정보 수정 폼
	@RequestMapping(value="/editForm.do", method=RequestMethod.POST)
	public String editForm(String id,Model model) 
			throws NamingException,IOException{
		
		MemberDTO memberDTO=sqlSession.selectOne("member.selectOne",id);
		model.addAttribute("memberDTO",memberDTO);
		//return "/member/editForm";//뷰이름
		return ".main.member.editForm";//뷰
	}//editForm() end

	//회원정보 수정
	@RequestMapping(value="/editPro.do", method=RequestMethod.POST)
	public String editPro(@ModelAttribute("memberDTO") MemberDTO memberDTO,HttpServletRequest request)
	throws NamingException,IOException{
		
		sqlSession.update("member.memberUpdate",memberDTO);
		
		
		
		HashMap <String,String>map =new HashMap<String,String>();
		map.put("id",memberDTO.getId());
		map.put("pwd",memberDTO.getPwd());
		
		memberDTO=sqlSession.selectOne("member.selectLogin",map);
		//model.addAttribute("memberDTO",memberDTO);
		request.getSession().setAttribute("memberDTO_session",memberDTO);						
		
		//return "main";//뷰이름 
		return "redirect:/myPage.do";//뷰 
	}

	//회원 탈퇴
	@RequestMapping(value="/memberDelete.do",method=RequestMethod.POST)
	public String userDelete(String id) throws NamingException,IOException{
		sqlSession.delete("member.memberDelete",id);
		//return "main";//뷰이름
		return ".main.member.logOut";//뷰
	}
	
}//class end 
