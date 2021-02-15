package org.bcr.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.bcr.model.CommentDTO;
import org.bcr.model.ContentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@Controller
public class CommentController {
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/{b_name}/comment.do")
	public String commentWrite(@PathVariable("b_name") String b_name,@ModelAttribute("commentDTO") CommentDTO CommentDTO) 
	throws NamingException,IOException{
		CommentDTO.setNameOfBoard(b_name);
		
//		int step = sqlSession.selectOne("comment.Commentre_step",CommentDTO);
//		System.out.println(CommentDTO.getRef());
//		System.out.println(step);
//		
		
		
		
		ContentDTO cdto = new ContentDTO();
		cdto.setB_name(b_name);
		cdto.setNo(CommentDTO.getNo());
		
		int refnum = 0;
		int check =  0;
		int check2 = 0;
		if(sqlSession.selectOne("comment.rcountmax",cdto) == null) {
			//처음 글을 올릴때;
			sqlSession.insert("comment.insertComment",CommentDTO);
			check = sqlSession.selectOne("comment.rcountmax",cdto);
			//System.out.println(check);
			cdto.setRef(check);
			sqlSession.update("comment.updatefirstComment",cdto);
			
		}else {
			 refnum = sqlSession.selectOne("comment.rcountmax",cdto);
			 if(CommentDTO.getRef() == 0) {
				//댓글일떄
				 //System.out.println("댓글입니다");
				 CommentDTO.setRef(refnum+1);
				 sqlSession.insert("comment.insertComment",CommentDTO);
			 }else {
				//대댓글일떄
				 //System.out.println("대댓글입니다");
				 sqlSession.insert("comment.insertComment",CommentDTO);
				 check = sqlSession.selectOne("comment.rcountmax",cdto);
				 cdto.setRef(check);
				 cdto.setO_ref(CommentDTO.getRef());
				 if(sqlSession.selectOne("comment.stepmax",cdto) == null) {
					 check2 = 0;
				 }else {
					 check2 = sqlSession.selectOne("comment.stepmax",cdto);
				 }
				 cdto.setRe_step(check2+1);
				 sqlSession.update("comment.updateCount",cdto);
			 }
		}
		
		//System.out.println(refnum);
		
		//System.out.println(CommentDTO.getRef());
		return "redirect:/"+b_name+"/content.do?no="+CommentDTO.getNo()+"&pageNum="+CommentDTO.getPageNum();
	}
	
	@RequestMapping("/{b_name}/comment_delete.do")
	public String commentDelete(@PathVariable("b_name") String b_name, String no_c,String no,String pageNum)
	throws NamingException,IOException{
		ContentDTO cDTO = new ContentDTO();
		cDTO.setNo(Integer.parseInt(no_c));
		cDTO.setB_name(b_name);
		sqlSession.delete("comment.deleteComment",cDTO);
		
		return "redirect:/"+b_name+"/content.do?no="+no+"&pageNum="+pageNum;
	}
	
	@RequestMapping("/{b_name}/comment_modi.do")
	public String modiWrite(@PathVariable("b_name") String b_name , @ModelAttribute("commentDTO") CommentDTO CommentDTO)
	throws NamingException,IOException{
		CommentDTO.setNameOfBoard(b_name);
		sqlSession.update("comment.updateComment",CommentDTO);
		
		return "redirect:/"+b_name+"/content.do?no="+CommentDTO.getNo()+"&pageNum="+CommentDTO.getPageNum(); 
	}
	
}
