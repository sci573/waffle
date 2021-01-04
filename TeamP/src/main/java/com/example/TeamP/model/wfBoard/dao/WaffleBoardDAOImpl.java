package com.example.TeamP.model.wfBoard.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.TeamP.model.wfBoard.dto.WaffleBoardDTO;
import com.example.TeamP.model.wfBoard.dto.WaffleBoardReplyDTO;

@Repository	//dao bean 등록
public class WaffleBoardDAOImpl implements WaffleBoardDAO {

	//의존 관계 주입
	@Inject
	SqlSession sqlSession;
	
	//레코드 갯수 계산
	@Override
	public int countArticle(String search_option, String keyword) {
		Map<String, Object> map=new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		return sqlSession.selectOne("board.countArticle", map);
	}

	//전체 리스트 출력
	@Override
	public List<WaffleBoardDTO> listAll(String search_option, String keyword, int start, int end) {
		Map<String, Object> map=new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		//mapper에는 2개 이상의 값을 전달할 수 없기 때문에 map을 사용해준다.(또는 dto사용)
		return sqlSession.selectList("board.listAll",map);
	}
	
	//조회수 증가 처리
	@Override
	public void increaseViewcnt(int bno) throws Exception {
		sqlSession.update("board.increateViewcnt", bno);
	}
	
	//레코드 조회
	@Override
	public WaffleBoardDTO read(int bno) throws Exception {
		return sqlSession.selectOne("board.read",bno);
	}
	
	//글작성
	@Override
	public void create(WaffleBoardDTO dto) throws Exception {
		sqlSession.insert("board.insert",dto);
	}

	//글수정
	@Override
	public void update(WaffleBoardDTO dto) throws Exception {
		sqlSession.update("board.update",dto);
	}

	//글삭제
	@Override
	public void delete(int bno) throws Exception {
		sqlSession.delete("board.delete",bno);
	}
	
	//글삭제 전 해당 글의 모든 댓글 삭제
	@Override
	public void delete_re(int bno) throws Exception {
		sqlSession.delete("board.delete_re",bno);
	}
	
	//글삭제 후 게시판 댓글 테이블의 번호 갱신
	@Override
	public void updateReBno(List<Integer> bno_list) {
		sqlSession.update("board.updateReBno", bno_list);
	}
	
	//글삭제 후 게시판 테이블의 번호 갱신
	@Override
	public void updateBno(List<Integer> bno_list) {
		sqlSession.update("board.updateBno", bno_list);
	}

	//댓글 리스트
	@Override
	public List<WaffleBoardReplyDTO> reply_list(int bno) {
		return sqlSession.selectList("board.listReply", bno);
	}

	//댓글 입력
	@Override
	public void reply_insert(WaffleBoardReplyDTO dto) {
		sqlSession.insert("board.insertReply", dto);
	}

	//댓글 삭제
	@Override
	public void reply_delete(WaffleBoardReplyDTO dto) {
		sqlSession.delete("board.deleteReply", dto);
	}
}
