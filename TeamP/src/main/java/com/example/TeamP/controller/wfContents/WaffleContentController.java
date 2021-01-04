package com.example.TeamP.controller.wfContents;


import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.TeamP.model.wfContent.dto.WaffleCommentDTO;
import com.example.TeamP.model.wfContent.dto.WaffleContentDTO;
import com.example.TeamP.service.wfContent.WaffleContentService;

@Controller
@RequestMapping("waffleContent/*")	//공통 url mapping
public class WaffleContentController {
	//로깅 처리
	private static final Logger logger=LoggerFactory.getLogger(WaffleContentController.class);
	
	//의존관계 주입
	@Inject
	WaffleContentService wfContService;
	
	//메인 뷰 화면으로 이동
	@RequestMapping("main_view.do")
	public String main_view(@ModelAttribute("message") String message, Model model) {
		logger.info(message);
		//message 전달
		model.addAttribute("message", message);
		return "content/main_view";
	}
	
	//메인 뷰 추천 컨텐츠 리스트 (랜덤으로 띄우기)
	@RequestMapping("list_reco.do")
	public String list_reco(Model model) {
		List<WaffleContentDTO> list=wfContService.list_reco();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		for(WaffleContentDTO dto : list) {
			logger.info(dto.getTitle());
			logger.info(dto.getPoster());
		}
		//list_reco.jsp에 전송할 데이터
		model.addAttribute("list", list);
		
		return "content/list_reco";
	}
	
	//메인 뷰 하단 전체 컨텐츠 출력 (랜덤으로 띄우기)
	@RequestMapping("list_all.do")
	// --신버전--
	public ModelAndView list_all(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.list_all();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마 전체");
		for(WaffleContentDTO dto : list) {
			logger.info(dto.getTitle());
			logger.info(dto.getPoster());
		}
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	/* --구버전--
	@ResponseBody//ajax는 http request body를 통해 파라미터를 전달한다. 참조 : https://ismydream.tistory.com/140
	public List<WaffleContentDTO> list_all(Model model) {
		List<WaffleContentDTO> list=wfContService.list_all();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		for(WaffleContentDTO dto : list) {
			logger.info(dto.getTitle());
			logger.info(dto.getPoster());
		}
		//list_all.jsp에 전송할 데이터
		//model.addAttribute("list", list);
		
		return list;
	}*/
	
	//메인 뷰 하단 드라마 출력
	//드라마 전체
	@RequestMapping("drama_M.do")
	public ModelAndView drama_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마 전체");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//로맨스
	@RequestMapping("drama_romance_M.do")
	public ModelAndView drama_romance_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_romance();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마 로맨스");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav;
	}
	
	//스릴러
	@RequestMapping("drama_thriller_M.do")
	public ModelAndView drama_thrille_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_thriller();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마 스릴러");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//액션
	@RequestMapping("drama_action_M.do")
	public ModelAndView drama_action_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_action();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마 액션");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//코미디
	@RequestMapping("drama_comedy_M.do")
	public ModelAndView drama_comedy_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_comedy();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마 코미디");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//SF
	@RequestMapping("drama_sf_M.do")
	public ModelAndView drama_sf_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_sf();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마 SF");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//메인 뷰 하단 영화 출력
	//영화 전체
	@RequestMapping("movie_M.do")
	public ModelAndView movie_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("영화 전체");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//로맨스
	@RequestMapping("movie_romance_M.do")
	public ModelAndView movie_romance_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_romance();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("영화 로맨스");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//스릴러
	@RequestMapping("movie_thriller_M.do")
	public ModelAndView movie_thriller_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_thriller();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("영화 스릴러");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//액션
	@RequestMapping("movie_action_M.do")
	public ModelAndView movie_action_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_action();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("영화 액션");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//코미디
	@RequestMapping("movie_comedy_M.do")
	public ModelAndView movie_comedy_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_comedy();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("코미디");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	//SF
	@RequestMapping("movie_sf_M.do")
	public ModelAndView movie_sf_M(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_sf();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("SF");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/main_bottom");
		mav.addObject("list", list);
		return mav; 
	}
	
	
	//영화만 띄워주는 화면으로 이동
	@RequestMapping("movie.do")
	public String movie() {
		return "content/movie/movie";
	}
		
	//드라마만 띄워주는 화면으로 이동
	@RequestMapping("drama.do")
	public String drama() {
		return "content/drama/drama";
	}
	
	//영화view 카테고리별 목록
	//액션
	@RequestMapping("movie_action.do")
	public ModelAndView movie_action(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_action();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("액션");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/movie/movie_category1");
		mav.addObject("list", list);
		return mav; 
	}
	//코미디
	@RequestMapping("movie_comedy.do")
	public ModelAndView movie_comedy(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_comedy();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("코미디");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/movie/movie_category2");
		mav.addObject("list", list);
		return mav; 
	}
	//SF
	@RequestMapping("movie_sf.do")
	public ModelAndView movie_sf(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_sf();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("SF");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/movie/movie_category3");
		mav.addObject("list", list);
		return mav; 
	}
	//로맨스
	@RequestMapping("movie_romance.do")
	public ModelAndView movie_romance(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_romance();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("로맨스");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/movie/movie_category4");
		mav.addObject("list", list);
		return mav; 
	}
	//스릴러
	@RequestMapping("movie_thriller.do")
	public ModelAndView movie_thriller(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.movie_thriller();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("스릴러");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/movie/movie_category5");
		mav.addObject("list", list);
		return mav; 
	}
	
	//드라마view 카테고리별 목록
	//액션
	@RequestMapping("drama_action.do")
	public ModelAndView drama_action(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_action();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("액션");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/drama/drama_category1");
		mav.addObject("list", list);
		return mav; 
	}
	//코미디
	@RequestMapping("drama_comedy.do")
	public ModelAndView drama_comedy(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_comedy();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("코미디");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/drama/drama_category2");
		mav.addObject("list", list);
		return mav; 
	}
	//SF
	@RequestMapping("drama_sf.do")
	public ModelAndView drama_sf(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_sf();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("SF");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/drama/drama_category3");
		mav.addObject("list", list);
		return mav; 
	}
	//드라마
	@RequestMapping("drama_romance.do")
	public ModelAndView drama_romance(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_romance();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("드라마");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/drama/drama_category4");
		mav.addObject("list", list);
		return mav; 
	}
	//스릴러
	@RequestMapping("drama_thriller.do")
	public ModelAndView drama_thriller(ModelAndView mav) {
		List<WaffleContentDTO> list = wfContService.drama_thriller();
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("스릴러");
		for(WaffleContentDTO dto : list)
			System.out.println(dto);
		mav.setViewName("content/drama/drama_category5");
		mav.addObject("list", list);
		return mav; 
	}
	
	//메인 뷰에서 이미지 클릭 시 해당 컨텐츠의 디테일 뷰로 이동
	@RequestMapping(value="detail_view.do", produces="text/plain;charset=UTF-8")
	public String detail_view(HttpSession session, @RequestParam("title") String title, WaffleContentDTO dto, Model model) {
		logger.info(title);
		dto = wfContService.detailCont(title);
		//세션의 userid 값 저장
		String userid=(String)session.getAttribute("userid");
		//찜목록에 기존 컨텐츠 있는지 확인
		int count=wfContService.countContent(title, userid);
		//detail_view.jsp에 전송할 데이터
		model.addAttribute("dto", dto);
		model.addAttribute("count", count);
		return "content/detail_view";
	}
	
	//디테일 뷰 댓글 목록 출력
	//ajax 방식으로 목록 갱신 ==> responseText 응답테스트(html)방식 : detail_view.jsp -> WaffleContentController -> comment_list.jsp
	@RequestMapping("commentList.do")
	public ModelAndView comment_list(/*@RequestParam("title") */String title, ModelAndView mav) {
		List<WaffleCommentDTO> comment_list = wfContService.comment_list(title);	//댓글 목록
		//리턴된 댓글들 출력 테스트
		for(WaffleCommentDTO dto : comment_list) {
			System.out.println(dto.getTitle());
			System.out.println(dto.getWriter());
			System.out.println(dto.getContent());
		}
		//ModelAndView 객체를 이용해서 포워딩
		mav.addObject("list",comment_list);
		mav.setViewName("content/comment_list");
		return mav;
	}
	
	//디테일 뷰 댓글 작성
	@RequestMapping("commentAdd.do")
	@ResponseBody //@RestController를 사용할때는 생략해도 되지만 @Controller일때는 명시해줘야 ajax 사용이 가능하다.(commentList에서는 사용하지 않아도 된다. 왜지?)
	public void comment_add(HttpServletRequest request, WaffleCommentDTO dto) {
		//HttpServletRequest 객체 안의 데이터를 불러와서 변수에 대입
		//String title=request.getParameter("title");
		String writer=request.getParameter("writer");
		//String content=request.getParameter("content");
		//값을 제대로 받아왔는지 출력 테스트
		System.out.println(writer);
		System.out.println(dto.getTitle()+"\n"+dto.getWriter()+"\n"+dto.getContent());
		//WaffleCommentDTO에 받아온 값 대입
		//dto.setTitle(title);
		//dto.setWriter(writer);
		//dto.setContent(content);
		//dto에 저장된 값 전달 후 mapper에서 댓글 insert
		wfContService.comment_add(dto);
	}
	
	//디테일 뷰 댓글 삭제
	@RequestMapping("commentDlt.do")
	@ResponseBody
	public void commentDlt(WaffleCommentDTO dto) {
		System.out.println("삭제할 댓글 : "+dto.getTitle()+"\t"+dto.getWriter()+"\t"+dto.getRno());
		wfContService.comment_dlt(dto);		
	}
	
	//관리자 디테일 수정 view로 이동
 	//@PathVariable과 @RequestParam 차이점 : https://mindols.tistory.com/107 참고
	@RequestMapping("admin_edit_view.do/{title}")
	public String admin_edit(@PathVariable("title") String title ,WaffleContentDTO dto, Model model){
		//dto에 저장된 제목을 담아서 보낸 값을 "dto"에 저장 후 수정 페이지로 리턴
		dto=wfContService.detailCont(title);
		model.addAttribute("dto", dto);
		return "content/detail_view_edit";
	}
	
	//관리자 디테일 수정
	@RequestMapping("admin_edit.do")
	public String admin_edit(WaffleContentDTO dto, Model model) {
		wfContService.admin_edit(dto);
		//생성된 페이지의 디테일 뷰로 가기 위해 title 값 저장
		model.addAttribute("title", dto.getTitle());
		return "redirect:/waffleContent/detail_view.do";
	}
	
	//관리자 디테일 삭제
	@RequestMapping("admin_delete.do/{title}")
	public String admin_delete(@PathVariable("title") String title, WaffleContentDTO dto) {
		//타이틀에 해당되는 댓글 행 삭제 (댓글 테이블이 컨텐츠 테이블을 참조하기 때문에(외래키) 먼저 삭제해줘야한다.)
		wfContService.admin_delete_re(title);
		//타이틀에 해당되는 컨텐츠 행 삭제
		wfContService.admin_delete(title);
		return "content/main_view";
	}
	
	//관리자 디테일 삽입 view로 이동
	@RequestMapping("admin_insert_view.do")
	public String admin_insert_view() {
		return "content/detail_view_insert";
	}
	
	//관리자 디테일 삽입
	@RequestMapping("admin_insert.do")
	public String admin_insert(WaffleContentDTO dto, Model model) {
		wfContService.admin_insert(dto);
		//생성된 페이지의 디테일 뷰로 가기 위해 title 값 저장
		model.addAttribute("title", dto.getTitle());
		return "redirect:/waffleContent/detail_view.do";
	}
	
	//검색 기능
	@RequestMapping("search.do")
	public ModelAndView search(@RequestParam(value = "inputArr[]") List<String> inputArr, ModelAndView mav) {
		//데이터 전달이 잘 되었는지 확인
		System.out.println("검색 값"+inputArr);
		List<WaffleContentDTO> list = wfContService.search(inputArr);
		//사진 리스트가 제대로 가져와졌는지 console창으로 출력해서 확인
		System.out.println("검색 결과");
		for(WaffleContentDTO dto : list) {
			System.out.println(dto);				
		}
		mav.addObject("list",list);
		mav.setViewName("content/search_view");
		return mav;
	}
}
