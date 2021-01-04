package com.example.TeamP.controller.wfBoard;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.TeamP.model.wfBoard.dto.WaffleBoardDTO;
import com.example.TeamP.model.wfBoard.dto.WaffleBoardReplyDTO;
import com.example.TeamP.service.wfBoard.Pager;
import com.example.TeamP.service.wfBoard.WaffleBoardService;

@Controller	//controller bean등록
@RequestMapping("waffleBoard/*")	//공통 url mapping
public class WaffleBoardController {
	//logger
	private static final Logger logger=LoggerFactory.getLogger(WaffleBoardController.class);
	
	//의존관계 주입
	@Inject
	WaffleBoardService wf_boardService;
	
	@RequestMapping("list.do")	//게시판 글 목록
	public ModelAndView list(
			@RequestParam(defaultValue = "writer") String search_option,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "1") int curPage
			) throws Exception {
		/*페이징 처리*/
		//레코드 갯수 계산
		int count=wf_boardService.countArticle(search_option, keyword);
		//페이지 관련 설정
		Pager pager=new Pager(count, curPage);
		int start=pager.getPageBegin();
		int end=pager.getPageEnd();
		
		/*리스트 출력*/
		List<WaffleBoardDTO> list=wf_boardService.listAll(search_option, keyword, start, end);//게시물 목록
		//System.out.println("리스트:"+list);//print문으로 들어오는 값을 찍어볼 수 있으나
		logger.error(list.toString());
		//logger.info(list.toString());//logger를 활용하는게 좋다.
		ModelAndView mav=new ModelAndView();
		HashMap<String, Object> map=new HashMap<>();
		map.put("list", list);//map에 자료 저장
		map.put("count", count/*list.size()*/);//갯수 파악
		logger.info("카운트 : "+count);
		map.put("pager", pager);//페이지 네비게이션을 위한 변수
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		
		mav.setViewName("board/list");//포워딩할 뷰의 이름
		mav.addObject("map", map);	//ModelAndView에 map을 저장
		return mav;	//board/list.jsp로 이동
	}
	
	@RequestMapping("view.do")	//게시판 글 뷰
	public ModelAndView view(int bno, HttpSession session) throws Exception	{
		//조회수 증가 처리
		wf_boardService.increaseViewcnt(bno, session);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/view");
		mav.addObject("dto", wf_boardService.read(bno));//자료 저장
		return mav;
	}
	
	@RequestMapping("write.do")	//게시판 글 작성 페이지로 이동
	public String write() {
		//글쓰기 폼 페이지로 이동
		return "board/write";
	}
	
	@RequestMapping("insert.do")	//게시판 글 작성
	public String insert(@ModelAttribute WaffleBoardDTO dto, HttpSession session) throws Exception {
		//작성자는 현재 로그인 한 회원.(jsp에서 sessionScope.userid를 input태그에 넣어서 전달해도 된다.)
		String writer=(String)session.getAttribute("userid");
		logger.info(writer.toString());
		//작성자 dto에 저장
		dto.setWriter(writer);
		//글 DB에 저장(레코드 추가)
		wf_boardService.create(dto);
		//게시물 목록으로 이동
		return "redirect:/waffleBoard/list.do";
	}
	
	@RequestMapping("edit.do")	//게시판 글 수정 페이지로 이동
	public String edit(int bno, WaffleBoardDTO dto, Model model) throws Exception {
		//수정할 게시물의 정보 가져오기
		dto=wf_boardService.read(bno);
		model.addAttribute("dto", dto);
		return "board/edit";
	}
	
	@RequestMapping("update.do")	//게시판 글 내용 수정
	public String update(WaffleBoardDTO dto) throws Exception {
		//logger를 이용한 dto 데이터 확인
		logger.info(dto.toString());
		//dto값이 비어있지 않을 때
		if(dto != null) {
			wf_boardService.update(dto);
		}
		return "redirect:/waffleBoard/view.do?bno="+dto.getBno();
	}
	
	@RequestMapping("delete.do")	//게시물 삭제
	public String delete(int bno) throws Exception {
		//게시물 번호에 해당되는 게시판 테이블의 행 삭제
		wf_boardService.delete(bno);
		return "redirect:/waffleBoard/list.do";	//목록으로 이동
	}
	
	@RequestMapping("replyList.do")	//게시판 댓글 리스트
	public ModelAndView reply_list(int bno, ModelAndView mav) {
		List<WaffleBoardReplyDTO> reply_list=wf_boardService.reply_list(bno);
		mav.setViewName("board/reply_list");	//뷰의 이름
		mav.addObject("list", reply_list);	//뷰에 전달할 데이터
		return mav;	//뷰로 이동
	}
	
	@RequestMapping("replyInsert.do")	//게시판 댓글 입력
	@ResponseBody	//ajax사용
	public void reply_insert(WaffleBoardReplyDTO dto, HttpSession session) {
		//세션에 저장된 댓글 작성자 아이디를 가져와서 처리
		String userid=(String)session.getAttribute("userid");
		//작성자 아이디를 dto에 저장
		dto.setReplyer(userid);
		//댓글을 테이블에 저장
		wf_boardService.reply_insert(dto);
		//Ajax로 값만 넘기고 끝나기 때문에 jsp 페이지로 가거나
		//데이터를 리턴하지 않는다. 이대로 끝
	}
	
	@RequestMapping("replyDelete.do")	//게시판 댓글 삭제
	@ResponseBody
	public void reply_delete(WaffleBoardReplyDTO dto) {
		System.out.println("삭제할 댓글 : "+dto.getBno()+"\t"+dto.getReplyer()+"\t"+dto.getRno());
		wf_boardService.reply_delete(dto);
	}
}
