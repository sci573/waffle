package com.example.TeamP.model.wfFavor.dto;

public class WaffleFavorDTO {
	private String userid;	//아이디
	private String title;	//제목
	private String poster;	//포스터(이미지)
	//getter,setter,toString()
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	@Override
	public String toString() {
		return "WaffleFavorDTO [userid=" + userid + ", title=" + title + ", poster=" + poster + "]";
	}
}
