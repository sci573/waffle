package com.example.TeamP.service.wfBoard;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.TeamP.model.wfBoard.dto.WaffleBoardDTO;
import com.example.TeamP.model.wfBoard.dto.WaffleBoardReplyDTO;

public interface WaffleBoardService {
	public int countArticle(String search_option, String keyword) throws Exception;	//레코드 갯수 계산
	public List<WaffleBoardDTO> listAll(String search_option, String keyword, int start, int end) throws Exception;	//목록
	
	public void increaseViewcnt(int bno, HttpSession session) throws Exception;	//조회수 증가
	public WaffleBoardDTO read(int bno) throws Exception;	//레코드 조회
	
	public void create(WaffleBoardDTO dto) throws Exception;	//글작성
	public void update(WaffleBoardDTO dto) throws Exception;	//글수정
	public void delete(int bno) throws Exception;	//글삭제
	
	public List<WaffleBoardReplyDTO> reply_list(int bno);	//댓글 리스트
	public void reply_insert(WaffleBoardReplyDTO dto);	//댓글 입력
	public void reply_delete(WaffleBoardReplyDTO dto);	//게시판 댓글 삭제
}
