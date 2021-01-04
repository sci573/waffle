package com.example.TeamP.model.wfBoard.dto;

import java.util.Date;

public class WaffleBoardDTO {
	private int bno;		//게시물 번호
	private String title;	//제목
	private String content;	//본문
	private String writer;	//작성자 id
	private Date regdate;	//작성일자
	private int viewcnt;	//조회수
	private int cnt;		//댓글 갯수
	private String show;	//화면 표시 여부
	//getter,setter,toString()
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getShow() {
		return show;
	}
	public void setShow(String show) {
		this.show = show;
	}
	@Override
	public String toString() {
		return "WaffleBoardDTO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", regdate=" + regdate + ", viewcnt=" + viewcnt + ", cnt=" + cnt + ", show=" + show + "]";
	}
}
