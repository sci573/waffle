package com.example.TeamP.controller.wfFavor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.TeamP.model.wfFavor.dto.WaffleFavorDTO;
import com.example.TeamP.service.wfFavor.WaffleFavorService;

@Controller
@RequestMapping("waffleFavor/*")	//공통 url mapping
public class WaffleFavorController {
	//로깅 처리
	private static final Logger logger=LoggerFactory.getLogger(WaffleFavorController.class);
	
	//의존관계 주입
	@Inject
	WaffleFavorService wfFavorService;
	
	//찜 리스트 출력
	@RequestMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		//세션의 userid 값 저장
		String userid=(String)session.getAttribute("userid");
		Map<String,Object> map=new HashMap<>();
		List<WaffleFavorDTO> list=wfFavorService.list(userid);
		//맵에 자료 추가
		map.put("list", list);
		map.put("count", list.size());
		//찜목록 view로 이동
		mav.setViewName("favorite/favor");
		mav.addObject("map", map);
		return mav;
	}
	
	//찜 추가
	@RequestMapping("insert.do")
	public String insert(HttpSession session, WaffleFavorDTO dto, Model model) {
		//세션의 userid 값 저장
		String userid=(String)session.getAttribute("userid");
		dto.setUserid(userid);
		//redirect시에 쿼리스트링을 사용하기 위해 title값 받아오기
		String title=dto.getTitle();
		//title 값 확인
		logger.info(title);
		//찜목록에 insert 처리 후 찜목록으로 이동
		wfFavorService.insert(dto);
		//model객체에 제목 값 전달
		model.addAttribute("title", title);
		//새로고침 하도록 수정
		return "redirect:/waffleContent/detail_view.do";
	}
	
	//찜 삭제
	@RequestMapping("delete.do")
	public String delete(HttpSession session, WaffleFavorDTO dto, Model model) {
		//세션의 userid 값 저장
		String userid=(String)session.getAttribute("userid");
		dto.setUserid(userid);
		//redirect시에 쿼리스트링을 사용하기 위해 title값 받아오기
		String title=dto.getTitle();
		//title 값 확인
		logger.info(title);
		//찜목록에 delete 처리 후 찜목록으로 이동
		wfFavorService.delete(dto);
		//model객체에 제목 값 전달
		model.addAttribute("title", title);
		//새로고침 하도록 수정
		return "redirect:/waffleContent/detail_view.do";
	}
}
