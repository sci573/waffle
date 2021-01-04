package com.example.TeamP.model.wfMember.dao;

import com.example.TeamP.model.wfMember.dto.WaffleMemberDTO;

public interface WaffleMemberDAO {
	public boolean loginCheck(WaffleMemberDTO dto);
	public String adminLoginCheck(WaffleMemberDTO dto);
	public WaffleMemberDTO viewWaffleMember(String userid);
	public WaffleMemberDTO viewWaffleAdmin(String userid);
	
	public void insertWfMember(WaffleMemberDTO dto);
	
	public boolean idCheck(String userid);
	public boolean emailCheck(String email);
	public boolean emailWho(String email);
	
	public void insertCode(WaffleMemberDTO dto);
	public boolean codeCheck(WaffleMemberDTO dto);
	public WaffleMemberDTO infoWaffleMember(WaffleMemberDTO dto);
	public void rollbackWfMember(String userid);
	public void emailPut(String email, int code);
	
	public WaffleMemberDTO infoWaffleAdmin(WaffleMemberDTO dto);
	public WaffleMemberDTO infoWaffleMember2(WaffleMemberDTO dto);
	
	public void updateWfAdmin(WaffleMemberDTO dto);
	public void updateWfMember(WaffleMemberDTO dto);
	public void deleteWfMember(WaffleMemberDTO dto);
	public void deleteFavor(WaffleMemberDTO dto);
	public void deleteReply(WaffleMemberDTO dto);
	public void deleteBoard(WaffleMemberDTO dto);
	public void deleteBoardRe(WaffleMemberDTO dto);
}
