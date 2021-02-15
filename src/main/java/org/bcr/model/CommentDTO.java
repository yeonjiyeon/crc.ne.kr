package org.bcr.model;
import java.util.Date;
public class CommentDTO {
	private int no_c;
	private String content_c;
	private Date regdate;
	private String id;
	private int no;
	private int pageNum;
	private String nameOfBoard;
	private int ref;
	private int re_step;
	
	
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public String getNameOfBoard() {
		return nameOfBoard;
	}
	public void setNameOfBoard(String nameOfBoard) {
		this.nameOfBoard = nameOfBoard;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getNo_c() {
		return no_c;
	}
	public void setNo_c(int no_c) {
		this.no_c = no_c;
	}
	public String getContent_c() {
		return content_c;
	}
	public void setContent_c(String content_c) {
		this.content_c = content_c;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
}
