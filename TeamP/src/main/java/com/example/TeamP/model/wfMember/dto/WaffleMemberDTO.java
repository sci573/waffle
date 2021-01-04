package com.example.TeamP.model.wfMember.dto;

import java.util.Date;

public class WaffleMemberDTO {
	private String userid;
	private String passwd;
	private String name;
	private String email;
	private Date join_date;
	private int c_code;
	//getter,setter,toString(),기본생성자
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public int getC_code() {
		return c_code;
	}
	public void setC_code(int c_code) {
		this.c_code = c_code;
	}
	//toString()
	@Override
	public String toString() {
		return "WaffleMemberDTO [userid=" + userid + ", passwd=" + passwd + ", name=" + name + ", email=" + email
				+ ", join_date=" + join_date + ", c_code=" + c_code + "]";
	}
	//기본생성자
	public WaffleMemberDTO() {
		
	}
}
