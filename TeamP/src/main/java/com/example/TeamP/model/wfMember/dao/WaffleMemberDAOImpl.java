package com.example.TeamP.model.wfMember.dao;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.TeamP.model.wfMember.dto.WaffleMemberDTO;

@Repository
public class WaffleMemberDAOImpl implements WaffleMemberDAO {

	@Inject
	SqlSession sqlSession;
	
	//로그인 서비스 (입력한 계정의 정보가 존재하는지 확인)
	@Override
	public boolean loginCheck(WaffleMemberDTO dto) {
		String name=sqlSession.selectOne("member.login_check",dto);
		//삼항연산자
		return (name != null) ? true : false;
	}
	
	//관리자 로그인 서비스
	@Override
	public String adminLoginCheck(WaffleMemberDTO dto) {
		String admin=sqlSession.selectOne("member.adminLogin_check", dto);
		return admin;
	}

	//모든 와플 멤버의 정보를 불러온다(login할때 session값에 넣기 위해 필요하다)
	@Override
	public WaffleMemberDTO viewWaffleMember(String userid) {
		return sqlSession.selectOne("member.viewMember", userid);
	}
	
	//와플 관리자의 정보를 불러온다(login할때 session값에 넣기 위해 필요하다)
	@Override
	public WaffleMemberDTO viewWaffleAdmin(String userid) {
		return sqlSession.selectOne("member.viewAdmin", userid);
	}
	
	//회원가입할때 정보 기입
	@Override
	public void insertWfMember(WaffleMemberDTO dto) {
		sqlSession.insert("member.insertWFM", dto);
	}
	
	//아이디 중복체크
	@Override
	public boolean idCheck(String userid) {
		String overlap=sqlSession.selectOne("member.id_check",userid);
		//member테이블에 아이디가 존재하면
		if(overlap != null) {
			return true;//참 값을 반환
		} else {//만약 member테이블에 아이디가 존재하지 않을 시
			overlap=sqlSession.selectOne("member.id_check_admin", userid);
			//삼항 연산자
			return (overlap != null) ? true : false;
		}
	}
	
	//이메일 중복체크
	@Override
	public boolean emailCheck(String email) {
		String overlap=sqlSession.selectOne("member.email_check", email);
		//member테이블에 이메일이 존재하면
		if(overlap != null) {
			return true;//참 값을 반환
		} else {//만약 member테이블에 이메일이 존재하지 않을 시
			overlap=sqlSession.selectOne("member.email_check_admin", email);
			//삼항 연산자
			return (overlap != null) ? true : false;
		}
	}
	
	//관리자 email인지 일반 유저 email인지 확인
	@Override
	public boolean emailWho(String email) {
		String overlap=sqlSession.selectOne("member.email_check_admin", email);
		return (overlap != null) ? true : false;
	}
	
	//이메일로 발송된 인증코드 해당 이메일이 들어있는 DB에 기입
	@Override
	public void insertCode(WaffleMemberDTO dto) {
		sqlSession.update("member.insertCode", dto);
	}
	
	//해당 이메일에 인증코드 존재하는지 확인
	@Override
	public boolean codeCheck(WaffleMemberDTO dto) {
		String userid=sqlSession.selectOne("member.codeCheck", dto);
		return (userid != null) ? true : false;
	}
	
	//해당되는 이메일에 인증코드가 존재하는게 확인되면 회원정보 수정을 위해 해당 이메일과 인증코드가 존재하는 DB row값 모두 불러오기
	@Override
	public WaffleMemberDTO infoWaffleMember(WaffleMemberDTO dto) {
		return sqlSession.selectOne("member.infoMember", dto);
	}
	
	//이메일 DB비우기(null값으로 설정)
	@Override
	public void rollbackWfMember(String userid) {
		sqlSession.update("member.rollback", userid);
	}
	
	//이메일 원상복구
	@Override
	public void emailPut(String email, int code) {
		Map<String, Object> map=new HashMap<>();
		map.put("email", email);
		map.put("code", code);
		sqlSession.update("member.emailPut", map);
	}
	
	//관리자 정보 수정시 불러오는 정보
	@Override
	public WaffleMemberDTO infoWaffleAdmin(WaffleMemberDTO dto) {
		return sqlSession.selectOne("member.infoWaffleAdmin", dto);
	}
	
	//회원정보 수정시 불러오는 정보
	@Override
	public WaffleMemberDTO infoWaffleMember2(WaffleMemberDTO dto) {
		return sqlSession.selectOne("member.infoWaffleMember2", dto);
	}
	
	//관리자 정보 수정
	@Override
	public void updateWfAdmin(WaffleMemberDTO dto) {
		sqlSession.update("member.updateWFA", dto);
	}
	
	//회원정보 수정
	@Override
	public void updateWfMember(WaffleMemberDTO dto) {
		sqlSession.update("member.updateWFM", dto);
	}

	//회원탈퇴
	@Override
	public void deleteWfMember(WaffleMemberDTO dto) {
		sqlSession.delete("member.deleteWFM", dto);
	}

	//회원탈퇴 전 favor삭제
	@Override
	public void deleteFavor(WaffleMemberDTO dto) {
		sqlSession.delete("member.deleteFavor", dto);
	}

	//회원탈퇴 전 reply삭제
	@Override
	public void deleteReply(WaffleMemberDTO dto) {
		sqlSession.delete("member.deleteReply", dto);
	}

	//회원탈퇴 전 board삭제
	@Override
	public void deleteBoard(WaffleMemberDTO dto) {
		sqlSession.delete("member.deleteBoard", dto);
	}

	//회원탈퇴 전 board_reply삭제
	@Override
	public void deleteBoardRe(WaffleMemberDTO dto) {
		sqlSession.delete("member.deleteBoardRe", dto);
	}
}
