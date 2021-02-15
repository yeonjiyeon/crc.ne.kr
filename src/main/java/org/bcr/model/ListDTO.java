package org.bcr.model;

public class ListDTO {

	private int start;
	private int cnt;
	private String b_name;
	private String keyword;
	private String serch_type;
	
	public int getStart() {
		return start;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSerch_type() {
		return serch_type;
	}
	public void setSerch_type(String serch_type) {
		this.serch_type = serch_type;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	
}
