package org.bcr.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.bcr.model.BoardDTO;
import org.bcr.model.CommentDTO;
import org.bcr.model.CommentListDTO;
import org.bcr.model.ContentDTO;
import org.bcr.model.ListDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class BoardController {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	
	//-----------------------------------------------------------
	//홈 //메인 화면 게시판별 리스트 출력하기
	@RequestMapping("/")
	public String home(Model model) throws NamingException,IOException{
		
		//8
		String[] boardNames = {
				"board"
				,"pop89"
				,"book"
				,"drama"
				,"exhibition"
				,"fashion"
				,"kpop"
				,"movie"};
		
		for(String b_name:boardNames) {	
			ListDTO lDTO = new ListDTO();
			lDTO.setB_name(b_name);
			List<BoardDTO> list=sqlSession.selectList("board.selectMainList", lDTO);
			//System.out.println("게시판 NO: "+list.get(0).getNo());
			
			for(BoardDTO dto : list) {
				HashMap map2=new HashMap();
				map2.put("b_name",b_name);
				map2.put("no",dto.getNo());
				dto.setCommentCount((int) sqlSession.selectOne("comment.commentCount",map2) );
			}
			
			//System.out.println(list2);
			model.addAttribute(b_name,list);
		}//for
		/*
		
		
		
		model.addAttribute(b_name+"_comment",list2);
		*/
		return "main";
	}
	//-----------------------------------------------------------
	//글쓰기 폼
	@RequestMapping("writeForm.do")
	public String writeForm(Model model,String b_name,String no,String ref,String re_step,String re_level ,String pageNum)
	{
		if(no==null) {//처음 글쓰기
		  no="0";
		  ref="1";
		  re_step="0";
		  re_level="0";
		}//if
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("no",no);
		model.addAttribute("ref",ref);
		model.addAttribute("re_step",re_step);
		model.addAttribute("re_level",re_level);
		model.addAttribute("b_name",b_name);
		switch(b_name) {
		case "board":	model.addAttribute("b_name2","자유게시판");
						break;
		case "pop89": 	model.addAttribute("b_name2","팝8090");
						break;
		case "book":	model.addAttribute("b_name2","책");
						break;
		case "drama":	model.addAttribute("b_name2","드라마");
		break;
		case "exhibition":	model.addAttribute("b_name2","전시회");
		break;
		case "fashion":	model.addAttribute("b_name2","패션");
		break;
		case "kpop":	model.addAttribute("b_name2","KPOP");
		break;
		case "movie":	model.addAttribute("b_name2","영화");
		break;
		}
		return ".main.board.writeForm";//뷰이름
	}//writeForm()) end
	
	//Db에 글쓰기
	@RequestMapping(value="writePro.do",method=RequestMethod.POST)
	public String writePro(@ModelAttribute("boardDTO") BoardDTO boardDTO, String pageNum, String b_name)
	throws NamingException,IOException{
		boardDTO.setNameOfBoard(b_name);
		
		int maxNum=0;//변수
		if(sqlSession.selectOne("board.maxNumber", boardDTO) != null) {
			maxNum=sqlSession.selectOne("board.maxNumber", boardDTO);
		}
		if(maxNum != 0) {//최대글번호가 0이 아니면
			maxNum=maxNum+1;
		}else{//최대 글번호가 0 이면
			maxNum=1;
		}
		
		
		if(boardDTO.getNo() != 0) {//답글이면
			//답글 끼워넣기 위치 확보
			sqlSession.update("board.reStep",boardDTO);
			boardDTO.setRe_step(boardDTO.getRe_step()+1);//글 순서
			boardDTO.setRe_level(boardDTO.getRe_level()+1);//글 깊이 
		}else {//원글
			boardDTO.setRef(new Integer(maxNum));//글 그룹번호 , 즉 현재 글번호를 ref에 넣어준다
			boardDTO.setRe_step(new Integer(0));//글 순서
			boardDTO.setRe_level(new Integer(0));//글 깊이 
		}
		System.out.println(boardDTO.toString());
		sqlSession.insert("board.insertBoard",boardDTO);
		
		return "redirect:/"+b_name+"/list.do";
		
	}//writePro() end
	
	//리스트
	@RequestMapping("/{b_name}/list.do")
	public String list(@PathVariable("b_name") String b_name,Model model,String pageNum,String serch_type, String keyword)
			throws NamingException,IOException{
		
		//검색 기능 구현 (민균)
		int serchtype_no = 0;
		int keyword_no = 0 ; 
		if(serch_type == null) {
			serch_type = "";
		}
		if(keyword == null) {
			keyword = "";
		}
		
		if(serch_type.equals("subject")) {
			//제목
			serchtype_no = 1;
		}else if(serch_type.equals("content")) {
			//내용
			//System.out.println(2);
			serchtype_no = 1;
		}else if(serch_type.equals("id")) {
			//작성자
			//System.out.println(3);
			serchtype_no = 1;
		}else if(serch_type.equals("all")) {
			//작성자 내용 제목
			serchtype_no = 2;
			
		}else {
			serchtype_no = 3;
		}
		if(keyword.equals("")) {
			keyword_no = 1;
			//System.out.println("비어있습니다");
		}else {
			keyword_no = 2;
			//System.out.println("내용이있습니다");
		}
		
		//검색 기능 구현 끝
		if(pageNum==null) {
			pageNum="1";
		}
		
		int pageSize=14;//한 페이지에 14개씩
		int currentPage=Integer.parseInt(pageNum);//현재 페이지
		
		int startRow=(currentPage-1)*pageSize+1;//한 페이지의 시작 행
		int endRow=currentPage*pageSize;//한 페이지의 마지막 행
		int count=0;
		int pageBlock=10;//1블럭당 10페이지씩 표시하려고
		
		HashMap<String , String> map=new HashMap<String,String>();
		map.put("b_name",b_name);
		map.put("serch_type", serch_type);
		map.put("keyword", keyword);
		// 작성자 , 내용 , 제목 단일 검색 시 
		if(serchtype_no == 1 && keyword_no == 2) {
			count=sqlSession.selectOne("board.selectCount2",map);//총 글 갯수 
			//System.out.println(count);
			// 작성자 + 내용 + 제목 복수 검색  시
		}else if(serchtype_no == 2 && keyword_no == 2){
			count = sqlSession.selectOne("board.selectCount3",map);
		}else {
			count=sqlSession.selectOne("board.selectCount",map);//총 글 갯수
		}
		
		int number=count-(currentPage-1)*pageSize;//글번호 
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		
		int result = currentPage/10;
		int startPage=result*10+1;
		//              0*10+1=1
		int endPage=startPage + pageBlock - 1;
		//               1+10-1=10
		if(endPage>pageCount) {
			endPage=pageCount;
		}
		
		ListDTO listDTO = new ListDTO();
		listDTO.setB_name(b_name);
		listDTO.setStart(startRow-1);
		listDTO.setCnt(pageSize);
		
		
		List<BoardDTO> list= null;
		listDTO.setKeyword(keyword);
		listDTO.setSerch_type(serch_type);
		
		
		if(serchtype_no == 1 && keyword_no == 2) {
			list=sqlSession.selectList("board.selectList2",listDTO);
			// 작성자 + 내용 + 제목 복수 검색  시
		}else if(serchtype_no == 2 && keyword_no == 2){
			list=sqlSession.selectList("board.selectList3",listDTO);
		}else {
			list=sqlSession.selectList("board.selectList",listDTO);
		}
		
		
		model.addAttribute("keyword",keyword);
		model.addAttribute("serch_type",serch_type);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		
		model.addAttribute("pageBlock",pageBlock);
		model.addAttribute("count",count);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("pageCount",pageCount);
		
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		
		model.addAttribute("number",number);
		model.addAttribute("list",list);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("b_name",b_name);
		
		
		switch(b_name) {
			case "board":	model.addAttribute("b_name2","자유게시판");
							break;
			case "pop89": 	model.addAttribute("b_name2","팝8090");
							break;
			case "book":	model.addAttribute("b_name2","책");
							break;
			case "drama":	model.addAttribute("b_name2","드라마");
			break;
			case "exhibition":	model.addAttribute("b_name2","전시회");
			break;
			case "fashion":	model.addAttribute("b_name2","패션");
			break;
			case "kpop":	model.addAttribute("b_name2","KPOP");
			break;
			case "movie":	model.addAttribute("b_name2","영화");
			break;
		}
		
		
		for(BoardDTO dto : list) {
			HashMap map2=new HashMap();
			map2.put("b_name",b_name);
			map2.put("no",dto.getNo());
			dto.setCommentCount((int) sqlSession.selectOne("comment.commentCount",map2) );
		}
		/*
		for(BoardDTO dto : list) {
			System.out.println(dto.toString());
		}
		*/
	
		return ".main.board.list";//뷰 리턴 
	}//list() end
	
	
	//글내용보기
	@RequestMapping("/{b_name}/content.do")
	public String content(@PathVariable("b_name") String b_name,Model model, String no, String pageNum, String CommentNum ) throws NamingException, IOException{
		
		if(CommentNum==null) {
			CommentNum="1";
		}
		
		int pageSize=10;//한 페이지에 10개씩
		int currentPage=Integer.parseInt(CommentNum);//현재 페이지
		
		int startRow=(currentPage-1)*pageSize+1;//한 페이지의 시작 행
		int endRow=currentPage*pageSize;//한 페이지의 마지막 행
		int count=0;
		int pageBlock=10;//1블럭당 10페이지씩 표시하려고
		
		HashMap<String , String> map=new HashMap<String,String>();
		map.put("b_name",b_name);
		map.put("no",no);
		//System.out.println(map);
		count=sqlSession.selectOne("comment.countTotal",map);//총 글 갯수 
		
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		
		int result = currentPage/10;
		int startPage=result*10+1;
		//              0*10+1=1
		int endPage=startPage + pageBlock - 1;
		//               1+10-1=10
		if(endPage>pageCount) {
			endPage=pageCount;
		}
		
		CommentListDTO clistDTO = new CommentListDTO();
		clistDTO.setB_name(b_name);
		clistDTO.setStart(startRow-1);
		clistDTO.setCnt(pageSize);
		clistDTO.setNo(Integer.parseInt(no));
		
		
		
		
		ContentDTO cDTO = new ContentDTO();
		cDTO.setNo(Integer.parseInt(no));
		cDTO.setB_name(b_name);
		sqlSession.update("board.readCount", cDTO); //조회수 증가
		
		BoardDTO dto = sqlSession.selectOne("board.contentBoard", cDTO);
		
		
		String content = dto.getContent();
		//content = content.replaceAll("\n", "<br>");
		
		//게시판별 댓글 가져오기 
		//댓글 갯수 가져오기
		int commentcount = sqlSession.selectOne("comment.countComment",cDTO);
		 
		
		
		if(commentcount > 0) {
			//댓글이 있을때
			List<CommentDTO> list_c = sqlSession.selectList("comment.selectComment",clistDTO);	
			model.addAttribute("list_c",list_c);
		}else {
			//댓글이 없을때
		}		

		if(commentcount == 0) {
			
		}else {
			int commentmaxcount = sqlSession.selectOne("comment.rcountmax",cDTO);
			model.addAttribute("comment_count",commentmaxcount);
		}
		
		
		
		
		
		
		
		
		
		model.addAttribute("count",count);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("pageCount",pageCount);
		
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		model.addAttribute("content", content);
		model.addAttribute("dto",dto);
		model.addAttribute("no", no);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("b_name",b_name);
		switch(b_name) {
		case "board":	model.addAttribute("b_name2","자유게시판");
						break;
		case "pop89": 	model.addAttribute("b_name2","팝8090");
						break;
		case "book":	model.addAttribute("b_name2","책");
						break;
		case "drama":	model.addAttribute("b_name2","드라마");
		break;
		case "exhibition":	model.addAttribute("b_name2","전시회");
		break;
		case "fashion":	model.addAttribute("b_name2","패션");
		break;
		case "kpop":	model.addAttribute("b_name2","KPOP");
		break;
		case "movie":	model.addAttribute("b_name2","영화");
		break;
		}
		
		//return "/board/content";//뷰 리턴
		return ".main.board.content";//뷰 리턴
	}
	
	//글 수정 폼
	@RequestMapping("updateForm.do")
	public String updateForm(Model model,String no,String pageNum,String b_name) 
			throws NamingException,IOException{
		
		ContentDTO cDTO = new ContentDTO();
		cDTO.setNo(Integer.parseInt(no));
		cDTO.setB_name(b_name);
		
		BoardDTO dto=sqlSession.selectOne("board.contentBoard",cDTO);
		
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("dto",dto);
		model.addAttribute("b_name",b_name);
		switch(b_name) {
		case "board":	model.addAttribute("b_name2","자유게시판");
						break;
		case "pop89": 	model.addAttribute("b_name2","팝8090");
						break;
		case "book":	model.addAttribute("b_name2","책");
						break;
		case "drama":	model.addAttribute("b_name2","드라마");
		break;
		case "exhibition":	model.addAttribute("b_name2","전시회");
		break;
		case "fashion":	model.addAttribute("b_name2","패션");
		break;
		case "kpop":	model.addAttribute("b_name2","KPOP");
		break;
		case "movie":	model.addAttribute("b_name2","영화");
		break;
		}
		//return "/board/updateForm";//뷰 이름
		return ".main.board.updateForm";//뷰 이름
	}//updateForm() end
	
	//DB글수정
	@RequestMapping(value="updatePro.do",method=RequestMethod.POST)
	public String updatePro(BoardDTO boardDTO,String pageNum,String b_name) 
			throws NamingException,IOException{
		
		boardDTO.setNameOfBoard(b_name);
		sqlSession.update("board.updateBoard",boardDTO);
		
		
		return "redirect:/"+b_name+"/content.do?no="+boardDTO.getNo()+"&pageNum="+pageNum;
	}
	//글삭제
	@RequestMapping("delete.do")
	public String delete(Model model , String no , String pageNum, String b_name) {
		
		ContentDTO cDTO = new ContentDTO();
		cDTO.setNo(Integer.parseInt(no));
		cDTO.setB_name(b_name);
		sqlSession.delete("board.deleteBoard",cDTO);
		return "redirect:/"+b_name+"/list.do";
	}//delete() end
	
}//class end
