package com.example.TeamP.model.wfContent.dto;

import java.util.Date;

public class WaffleCommentDTO {
	private int rno;	//댓글 순서를 구분하기 위한 번호
    private String title;	//댓글이 달릴 게시물 제목
    private String writer;	//댓글 작성자
    private String content;	//댓글 내용
    private Date reg_date;	//댓글이 달린 시간
    //getter,setter,toString
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "WaffleCommentDTO [rno=" + rno + ", title=" + title + ", writer=" + writer + ", content=" + content
				+ ", reg_date=" + reg_date + "]";
	}   
}
