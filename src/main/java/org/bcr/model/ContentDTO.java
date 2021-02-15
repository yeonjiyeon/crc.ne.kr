package org.bcr.model;

public class ContentDTO {
	private String b_name;
	private int no;
	private int ref;
	private int o_ref;
	private int re_step;
	
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getO_ref() {
		return o_ref;
	}
	public void setO_ref(int o_ref) {
		this.o_ref = o_ref;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
}
