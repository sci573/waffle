package com.example.TeamP.service.wfMember;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.TeamP.model.wfMember.dao.WaffleMemberDAO;
import com.example.TeamP.model.wfMember.dto.WaffleMemberDTO;

@Service
public class WaffleMemberServiceImpl implements WaffleMemberService {

	@Inject
	WaffleMemberDAO wf_memberDao;
	
	//로그인 서비스 (입력한 계정의 정보가 존재하는지 확인)
	@Override
	public boolean loginCheck(WaffleMemberDTO dto, HttpSession session) {
		boolean result=wf_memberDao.loginCheck(dto);
		if(result) {//로그인에 성공할 시
			//유저 정보를 불러온다.
			WaffleMemberDTO w_dto=viewWaffleMember(dto.getUserid());
			//세션객체에 값 저장
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("passwd", w_dto.getPasswd());
			session.setAttribute("name", w_dto.getName());
			//세션객체 확인
			System.out.println(session.getAttribute("userid"));
			System.out.println(session.getAttribute("name"));
		}
		return result;
	}

	//관리자 로그인 서비스
	@Override
	public String adminLoginCheck(WaffleMemberDTO dto, HttpSession session) {
		String admin=wf_memberDao.adminLoginCheck(dto);
		if(admin != null) {//관리자 로그인에 성공할 시
			//관리자 정보를 불러온다.
			WaffleMemberDTO a_dto=wf_memberDao.viewWaffleAdmin(dto.getUserid());
			/* 세션객체에 값 저장 */
			//관리자 권한용 세션 저장
			session.setAttribute("admin_userid", dto.getUserid());
			session.setAttribute("admin_passwd", a_dto.getPasswd());
			//일반 유저용 세션 저장
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("passwd", a_dto.getPasswd());
			session.setAttribute("name", a_dto.getName());
			//세션객체 확인
			System.out.println(session.getAttribute("admin_userid")+"\n"+session.getAttribute("userid"));
			System.out.println(session.getAttribute("name"));
		}
		return admin;
	}

	//로그아웃 서비스
	@Override
	public void logout(HttpSession session) {
		//세션 초기화
		session.invalidate();
	}

	//와플 멤버의 모든 정보를 불러온다(login할때 session값에 넣기 위해 필요하다)
	@Override
	public WaffleMemberDTO viewWaffleMember(String userid) {
		return wf_memberDao.viewWaffleMember(userid);
	}

	//회원가입할때 정보 기입
	@Override
	public void insertWfMember(WaffleMemberDTO dto) {
		wf_memberDao.insertWfMember(dto);
	}
	
	//아이디 중복체크
	@Override
	public boolean idCheck(String userid) {
		boolean result=wf_memberDao.idCheck(userid);
		return result;
	}
	
	//비밀번호 중복체크
	@Override
	public boolean emailCheck(String email) {
		boolean result=wf_memberDao.emailCheck(email);
		return result;
	}
	
	//관리자 email인지 일반 유저 email인지 확인
	@Override
	public boolean emailWho(String email) {
		boolean check=wf_memberDao.emailWho(email);
		return check;
	}
	
	//이메일로 발송된 인증코드 해당 이메일이 들어있는 DB에 기입
	@Override
	public void insertCode(WaffleMemberDTO dto) {
		wf_memberDao.insertCode(dto);
	}
	
	//해당 이메일에 인증코드 존재하는지 확인
	@Override
	public boolean codeCheck(WaffleMemberDTO dto) {
		boolean result=wf_memberDao.codeCheck(dto);
		return result;
	}
	
	//해당되는 이메일에 인증코드가 존재하는게 확인되면 회원정보 수정을 위해 해당 이메일과 인증코드가 존재하는 DB row값 모두 불러오기
	@Override
	public WaffleMemberDTO infoWaffleMember(WaffleMemberDTO dto) {
		return wf_memberDao.infoWaffleMember(dto);
	}
	
	//이메일 DB비우기(null값으로 설정)
	@Override
	public void rollbackWfMember(String userid) {
		wf_memberDao.rollbackWfMember(userid);
	}
	
	//이메일 원상복구
	@Override
	public void emailPut(String email, int code) {
		wf_memberDao.emailPut(email,code);
	}
	
	//관리자 정보 수정시 불러오는 정보
	@Override
	public WaffleMemberDTO infoWaffleAdmin(WaffleMemberDTO dto) {
		return wf_memberDao.infoWaffleAdmin(dto);
	}
	
	//회원정보 수정시 불러오는 정보 (기존에 존재하던 일반 유저의 데이터를 불러온다)
	@Override
	public WaffleMemberDTO infoWaffleMember2(WaffleMemberDTO dto) {
		return wf_memberDao.infoWaffleMember2(dto);
	}
	
	//관리자 정보 수정
	@Override
	public void updateWfAdmin(WaffleMemberDTO dto) {
		wf_memberDao.updateWfAdmin(dto);
		
	}
	
	//회원정보 수정
	@Override
	public void updateWfMember(WaffleMemberDTO dto) {
		wf_memberDao.updateWfMember(dto);
	}

	//회원탈퇴
	@Override
	public void deleteWfMember(WaffleMemberDTO dto) {
		wf_memberDao.deleteWfMember(dto);
	}

	//회원탈퇴 전 favor삭제
	@Override
	public void deleteFavor(WaffleMemberDTO dto) {
		wf_memberDao.deleteFavor(dto);
	}

	//회원탈퇴 전 reply삭제
	@Override
	public void deleteReply(WaffleMemberDTO dto) {
		wf_memberDao.deleteReply(dto);
	}

	//회원탈퇴 전 board삭제
	@Override
	public void deleteBoard(WaffleMemberDTO dto) {
		wf_memberDao.deleteBoard(dto);
	}

	//회원탈퇴 전 board_reply삭제
	@Override
	public void deleteBoardRe(WaffleMemberDTO dto) {
		wf_memberDao.deleteBoardRe(dto);
	}
}
