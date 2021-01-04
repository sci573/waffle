package com.example.TeamP.service.wfBoard;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.TeamP.model.wfBoard.dao.WaffleBoardDAO;
import com.example.TeamP.model.wfBoard.dto.WaffleBoardDTO;
import com.example.TeamP.model.wfBoard.dto.WaffleBoardReplyDTO;

@Service	//service bean 등록
public class WaffleBoardServiceImpl implements WaffleBoardService {

	//의존관계 주입
	@Inject
	WaffleBoardDAO wf_boardDao;
	
	//레코드 갯수 계산
	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		return wf_boardDao.countArticle(search_option, keyword);
	}

	//전체 리스트 출력
	@Override
	public List<WaffleBoardDTO> listAll(String search_option, String keyword, int start, int end) throws Exception {
		return wf_boardDao.listAll(search_option, keyword, start, end);
	}

	//조회수 증가 처리
	@Override
	public void increaseViewcnt(int bno, HttpSession session) throws Exception {
		long update_time=0;
		if(session.getAttribute("update_time_"+bno)!=null) {
			//최근에 조회수를 올린 시간
			update_time=(long)session.getAttribute("update_time_"+bno);
		}
		long current_time=System.currentTimeMillis();
		if(current_time - update_time > 5*1000) {//24*60*60*1000(하루)
			//조회수 증가 처리
			wf_boardDao.increaseViewcnt(bno);
			//조회수를 올린 시간 저장
			session.setAttribute("update_time_"+bno, current_time);
		}
	}
	
	//레코드 조회
	@Override
	public WaffleBoardDTO read(int bno) throws Exception {
		return wf_boardDao.read(bno);
	}
	
	//글작성
	@Override
	public void create(WaffleBoardDTO dto) throws Exception {
		//레코드 추가
		wf_boardDao.create(dto);		
	}

	//글수정
	@Override
	public void update(WaffleBoardDTO dto) throws Exception {
		wf_boardDao.update(dto);
	}

	//글삭제
	@Transactional	//wf_b_reply 테이블도 삭제해줘야 하기 때문에 트랜잭션 사용(연동 테이블 관련 처리할때 사용)
	@Override
	public void delete(int bno) throws Exception {
		//게시물 번호에 해당되는 댓글 테이블의 행 삭제
		wf_boardDao.delete_re(bno);
		//wf_board레코드 삭제
		wf_boardDao.delete(bno);
		
		/* 글이 삭제되면 번호를 갱신해줘야한다. (중요 : 게시판 댓글 테이블의 bno와 게시판 테이블의 bno 모두 갱신해줘야한다.) */		
		//게시물마다 bno의 값을 갱신하기 위해서 list를 생성한다.(mapper에서 배열 또는 list형식으로 데이터를 받아야 한다.)
		List<Integer> bno_list=new ArrayList<Integer>();
		
		//countArticle() 메소드를 사용하기 위해 search_option과 keyword 변수 설정하기
		String search_option="writer";
		String keyword="";
		//board 테이블의 총 row 갯수 알아오기 (하나가 삭제되어서 기존의 갯수보다 -1개가 반환된다) -> count 변수에 갯수 저장
		int count=countArticle(search_option, keyword);
		
		//list에 삭제한 게시물의 번호 다음부터 끝 번호까지 bno 값 저장
		for(int i=bno; i<=count+1; i++) {
			bno_list.add(i);
		}
		//게시물 댓글의 번호 갱신
		wf_boardDao.updateReBno(bno_list);
		//게시물의 번호 갱신
		wf_boardDao.updateBno(bno_list);
	}

	//댓글 리스트
	@Override
	public List<WaffleBoardReplyDTO> reply_list(int bno) {
		return wf_boardDao.reply_list(bno);
	}

	//댓글 입력
	@Override
	public void reply_insert(WaffleBoardReplyDTO dto) {
		wf_boardDao.reply_insert(dto);
	}

	//댓글 삭제
	@Override
	public void reply_delete(WaffleBoardReplyDTO dto) {
		wf_boardDao.reply_delete(dto);		
	}
}
