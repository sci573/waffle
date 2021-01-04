package com.example.TeamP.model.wfBoard.dao;

import java.util.List;

import com.example.TeamP.model.wfBoard.dto.WaffleBoardDTO;
import com.example.TeamP.model.wfBoard.dto.WaffleBoardReplyDTO;

public interface WaffleBoardDAO {
	public int countArticle(String search_option, String keyword);	//레코드 갯수 계산
	public List<WaffleBoardDTO> listAll(String search_option, String keyword, int start, int end);	//목록
	
	public void increaseViewcnt(int bno) throws Exception;	//조회수 증가
	public WaffleBoardDTO read(int bno) throws Exception;	//레코드 조회
	
	public void create(WaffleBoardDTO dto) throws Exception;	//글작성
	public void update(WaffleBoardDTO dto) throws Exception;	//글수정
	public void delete(int bno) throws Exception;	//글삭제
	public void delete_re(int bno) throws Exception;	//글삭제 전 해당 글에 있는 모든 댓글 삭제
	public void updateReBno(List<Integer> bno_list);	//글삭제 후 게시판 댓글 테이블의 번호 갱신
	public void updateBno(List<Integer> bno_list);	//글삭제 후 게시판 테이블의 번호 갱신
	
	public List<WaffleBoardReplyDTO> reply_list(int bno);	//댓글 리스트
	public void reply_insert(WaffleBoardReplyDTO dto);	//댓글 입력
	public void reply_delete(WaffleBoardReplyDTO dto);	//게시판 댓글 삭제
}
