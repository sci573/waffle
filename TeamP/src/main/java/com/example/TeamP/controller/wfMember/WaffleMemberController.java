package com.example.TeamP.controller.wfMember;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.TeamP.model.wfMember.dto.WaffleMemberDTO;
import com.example.TeamP.service.wfMember.WaffleMemberService;

@Controller
@RequestMapping("waffleMember/*")	//공통 url mapping
public class WaffleMemberController {
	//로깅 처리
	private static final Logger logger=LoggerFactory.getLogger(WaffleMemberController.class);
	
	//의존관계 주입
	@Inject
	WaffleMemberService wfmemberService;
	//@Autowired
	//CacheManager cacheManager;	//캐시 삭제를 위해 캐시매니저 사용
	
	//로그인 화면으로 이동
	@RequestMapping("login.do")
	public String login(@ModelAttribute("message") String message/*, String cacheName*/) {
		logger.info(message);
		//모든 캐시 삭제
		//cacheManager.getCache(cacheName).clear();
		/*
		 * if(message != null) { ModelAndView mav=new ModelAndView();
		 * mav.addObject("message", "welcome"); }
		 */
		return "member/login";	//login.jsp로 이동
	}
	
	//로그인할 계정이 DB에 존재하는지 확인
	@RequestMapping("login_check.do")
	public String login_check(WaffleMemberDTO dto, HttpSession session, Model model) {
		//로그인 성공 true, 실패 false
		boolean result=wfmemberService.loginCheck(dto, session);
		//관리자 로그인 확인용 변수
		String admin=wfmemberService.adminLoginCheck(dto, session);
		//결과 확인
		System.out.println("일반유저 : "+result+"\n관리자 : "+admin);
		if(admin!=null) {
			//뷰에 전달할 값
			model.addAttribute("message", "hello");
			return "redirect:/waffleContent/main_view.do";
		} else if(result) {//로그인 성공
			//뷰에 전달할 값
			model.addAttribute("message", "hello");
			return "redirect:/waffleContent/main_view.do";
			//mav.setViewName("content/main_view");
			//뷰에 전달할 값
			//mav.addObject("message", "success");
		} else {//로그인 실패
			//뷰에 전달할 값
			model.addAttribute("message", "error");
			return "member/login";		
			//mav.setViewName("member/login");
			//뷰에 전달할 값
			//mav.addObject("message", "error");
		}
		//return mav;
	}//login_check()
	
	//로그아웃
	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav/*, String cacheName*/) {
		//세션 초기화
		wfmemberService.logout(session);
		//모든 캐시 삭제
		//cacheManager.getCache(cacheName).clear();
		//리다이렉트 방식 사용
		mav.setViewName("redirect:/waffleMember/home.do");
		mav.addObject("message", "byebye");
		return mav;
	}
	
	//로그아웃 후 메인화면으로 이동
	@RequestMapping("home.do")
	public String home(@ModelAttribute("message") String message) {
		logger.info(message);
		return "home";	//home.jsp로 이동
	}
	
	//회원가입 화면으로 이동
	@RequestMapping("join.do")
	public String join() {
		return "member/join";	//join.jsp로 이동
	}
	
	//회원가입 할 계정 DB에 입력하기
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute WaffleMemberDTO dto, RedirectAttributes redirectAttributes) {
		wfmemberService.insertWfMember(dto);
		//redirect시 전달할 메시지와 값 저장
		redirectAttributes.addFlashAttribute("message", "welcome");
		return "redirect:/waffleMember/login.do";
	}
	
	//아이디 중복 체크
	@RequestMapping("id_check.do")
	@ResponseBody//ajax는 http request body를 통해 파라미터를 전달한다.
	public Map<String, Object> id_check(@RequestParam("userid") String userid) {
		boolean result=wfmemberService.idCheck(userid);
		Map<String, Object> map=new HashMap<>();
		
		System.out.println(result);
		
		if(result) {//아이디 중복 체크 확인(아이디가 존재할 시)
			map.put("result", "true");
			//뷰에 전달할 값
			return map;
		} else {//아이디 중복 체크 확인(아이디가 존재하지 않을 시)
			map.put("result", "false");
			//뷰에 전달할 값
			return map;
		}
	}
	
	//이메일 중복 체크
	@RequestMapping("email_check.do")
	@ResponseBody//ajax사용
	public Map<String, Object> email_check(@RequestParam("email") String email) {
		boolean result=wfmemberService.emailCheck(email);
		Map<String, Object> map=new HashMap<>();
		
		System.out.println(result);
		
		if(result) {//아이디 중복 체크 확인(아이디가 존재할 시)
			map.put("result", "true");
			//뷰에 전달할 값
			return map;
		} else {//아이디 중복 체크 확인(아이디가 존재하지 않을 시)
			map.put("result", "false");
			//뷰에 전달할 값
			return map;
		}
	}

	
	/*	로그인 전 회원정보 수정 (세션 off) - 아이디 비밀번호 찾기	*/
	
	//계정 찾기 페이지로 이동
	@RequestMapping("find.do")
	public String find(@ModelAttribute("message") String message) {
		logger.info(message);
		return "member/find";
	}
	
	//메일 보내기
	@Inject
	JavaMailSender mailSender;
	
	@RequestMapping("send.do")
	public String send(@RequestParam("email") String email, Model model, WaffleMemberDTO dto, HttpSession session) {
		try {
			//MimeMessage : 이메일 객체
			MimeMessage mail=mailSender.createMimeMessage();
			//받는 사람(입력된 이메일 주소)
			mail.addRecipient(RecipientType.TO,new InternetAddress(email));
			//보내는 사람(이메일주소 + 이름)
			/* mail.setFrom(new InternetAddress("bdd3452@gmail.com")); */
			
			//이메일로 인증코드를 보내기 전에 DB에 입력한 이메일이 존재하는지 조회
			boolean result=wfmemberService.emailCheck(email);
			if(result) {//이메일이 존재하면
				//이메일을 세션 영역에 저장(인증코드 기입 후 계정 확인할 때 체크해야 함 -> codeConfirm.do에서 사용)
				session.setAttribute("email", email);
				
				//세션 영역에 저장된 이메일이 관리자의 이메일인지 일반 유저의 이메일인지 확인해야함
				boolean check=wfmemberService.emailWho((String)session.getAttribute("email"));
				if(check) {
					model.addAttribute("message", "admin");
					return "redirect:/waffleMember/login.do";
				}
				
				//인증 코드 생성(계정 찾는데 사용)
				double rand = Math.random();
				int certify=(int)(rand * 1000000);
				//인증 코드 세션 영역에 저장(뒤로가기 눌렀을 때, 홈 화면으로 이동했을 때 이메일 null값처리에서 값 생성해주기)
				session.setAttribute("code", certify);
				
				//인증 코드를 입력한 email에 해당되는 DB row에 입력해야함.
				dto.setEmail(email);//이메일 set
				dto.setC_code(certify);//인증코드 set
				wfmemberService.insertCode(dto);//dto값 전달
				
				//이메일 제목
				mail.setSubject("계정 찾기 안내", "utf-8");
				//이메일 본문 (인증코드 전송)
				mail.setText("회원님의 인증 코드는 \'"+certify+"\' 입니다.", "utf-8");
				//이메일 보내기
				mailSender.send(mail);			
				
				model.addAttribute("message", "sended");
				return "redirect:/waffleMember/checkCode.do";
			}else {//이메일이 존재하지 않으면
				model.addAttribute("message", "nowhere");
				return "redirect:/waffleMember/login.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "failed");
			return "redirect:/waffleMember/login.do";
		}
	}
	
	//인증 코드 확인하는 페이지로 이동
	@RequestMapping("checkCode.do")
	public String checkCode(@ModelAttribute("message") String message) {
		logger.info(message);
		return "member/check_code";
	}
	
	//인증 코드 확인하기
	@RequestMapping("codeConfirm.do")
	public ModelAndView codeConfirm(@RequestParam("c_code") int c_code, HttpSession session /*RedirectAttributes redirectAttributes*/) {
		//c_code와 session영역에 있던 email
		WaffleMemberDTO dto=new WaffleMemberDTO();
		dto.setEmail((String)session.getAttribute("email"));
		dto.setC_code(c_code);
		boolean result=wfmemberService.codeCheck(dto);
		//session영역에 있던 email을 불러오면 session 초기화 -- 만약 뒤로가기 후 코드를 재입력했을 때, 홈 화면으로 이동했을 때 email에 null값이 들어가는 것을 방지하기 위해서 취소
		//session.invalidate();
		
		//포워딩을 위해 ModelAndView 객체 선언	--> ModelAndView는 포워드, 리다이렉트 방식 둘 다 이용 가능하다. 참조 : https://codediver.tistory.com/77
		ModelAndView mav=new ModelAndView();
		
		//입력한 이메일에 해당되는 인증 코드가 존재한다면
		if(result==true) {
			//입력한 이메일에 해당되는 사용자의 정보를 모두 불러와서 dto에 저장
			WaffleMemberDTO u_dto=wfmemberService.infoWaffleMember(dto);//사용자의 데이터를 담을 새 DTO 객체 생성
			//데이터를 제대로 받아오는지 확인
			logger.info(u_dto.getUserid()+u_dto.getName()+u_dto.getEmail());
			
			//해당 사용자의 이메일을 비워준다(null값으로 처리해준다)
			//왜냐하면 이메일은 갱신할 여지가 있다.(중복방지 코드에서 에러발생을 방지하기 위함)
			//userid 값을 전달받아서 처리
			wfmemberService.rollbackWfMember(u_dto.getUserid());
			
			//---------포워딩 할시에 사용----------//
			mav.addObject("dto", u_dto);
			mav.setViewName("member/info_view");
			return mav;
			
			//---------리다이렉트 할시에 사용----------//
			//redirect시 전달할 메시지와 값 저장
			//redirectAttributes.addFlashAttribute("dto", u_dto);
			//사용자 수정페이지로 이동
			//return "redirect:/waffleMember/info_view.do";
		} else {
			//---------포워딩 할시에 사용----------//
			mav.addObject("message", "wrongCode");
			mav.setViewName("member/find");
			return mav;
			
			//---------리다이렉트 할시에 사용----------//
			//redirectAttributes.addFlashAttribute("message", "wrongCode");
			//return "redirect:/waffleMember/find.do";
		}
	}
	
	//코드 인증 중에 뒤로가기 눌렀을 때 이메일을 null값에서 다시 원상복구 시켜준다.
	@RequestMapping("email_put.do")
	@ResponseBody	//ajax사용
	public void email_put(String email, int code) {
		//세션값에 저장되어있던 email과 code의 값을 이용해서 복구
		wfmemberService.emailPut(email,code);
	}
	
	
	/*	로그인 후 회원정보 수정 (세션 on) - 비밀번호 등 개인정보 수정하기	*/
	
	//회원정보를 수정 전 비밀번호를 체크하는 페이지로 이동 (로그인 되어있는 회원이 맞는지 확인)
	@RequestMapping("idpwCheck_view.do")
	public String idpwCheck_view(@ModelAttribute("dto") WaffleMemberDTO dto) {
		logger.info(dto.getUserid());
		return "member/idpwCheck_view";
	}
	
	//회원정보를 수정하는 페이지로 이동
	@RequestMapping("info_view.do")
	public String infoView(@ModelAttribute("dto") WaffleMemberDTO dto, Model model, HttpSession session) {
		//로그인 되어있는 회원의 정보 확인 (Email과 Name은 session객체에 없기 때문에 NULL처리되어 출력될 것이다.)
		logger.info(dto.getUserid()+dto.getEmail()+dto.getName()+dto.getPasswd());
		
		//로그인 된 유저가 관리자인지 일반 유저인지 확인해야함
		if(dto.getUserid().equals(session.getAttribute("admin_userid"))) {//관리자일때
			WaffleMemberDTO a_dto=wfmemberService.infoWaffleAdmin(dto);//관리자의 데이터를 담을 새 DTO 객체 생성
			//데이터를 제대로 받아오는지 확인
			logger.info(a_dto.getUserid()+a_dto.getName()+a_dto.getEmail()+a_dto.getPasswd());
			//받아온 데이터를 전송할 데이터에 넣어준다.
			model.addAttribute("dto", a_dto);
		} else {
			//사용자의 정보를 모두 불러와서 dto에 저장
			WaffleMemberDTO u_dto=wfmemberService.infoWaffleMember2(dto);//사용자의 데이터를 담을 새 DTO 객체 생성
			//데이터를 제대로 받아오는지 확인
			logger.info(u_dto.getUserid()+u_dto.getName()+u_dto.getEmail()+u_dto.getPasswd());
			//받아온 데이터를 전송할 데이터에 넣어준다.
			model.addAttribute("dto", u_dto);
		}
		return "member/info_view";
	}
	
	//회원 정보 수정하기
	@RequestMapping("update.do")
	public String update(WaffleMemberDTO dto, RedirectAttributes redirectAttributes, HttpSession session) {
		//정보를 수정하는 유저가 관리자인지 일반 유저인지 확인해야함
		if(dto.getUserid().equals(session.getAttribute("admin_userid"))) {//관리자일때
			wfmemberService.updateWfAdmin(dto);
			redirectAttributes.addFlashAttribute("message", "modified");
		} else {
			//회원정보 수정시에 인증코드를 비워준다(null값으로 처리함)
			//왜냐하면 인증코드는 계정정보를 찾을 때가 아니면 null값으로 유지해야 한다.
			wfmemberService.updateWfMember(dto);
			//redirect시 전달할 메시지와 값 저장
			redirectAttributes.addFlashAttribute("message", "modified");
		}
		//세션객체에 로그인 정보가 있을 경우 비워준다.
		session.invalidate();
		//로그인 페이지로 이동
		return "redirect:/waffleMember/login.do";
	}
	
	//회원 탈퇴
	@RequestMapping("delete.do")
	public ModelAndView delete(WaffleMemberDTO dto, HttpSession session, ModelAndView mav) {
		//탈퇴하기 전에 외래키로 사용된 favor와 reply를 지워줘야한다.
		wfmemberService.deleteFavor(dto);//favor삭제
		wfmemberService.deleteReply(dto);//reply삭제
		//추가적으로 게시판에 작성한 글과 댓글 모두 지워줘야한다.
		wfmemberService.deleteBoard(dto);
		wfmemberService.deleteBoardRe(dto);
		//해당 유저의 레코드 삭제 처리
		wfmemberService.deleteWfMember(dto);
		//세션객체에 아무 것도 남지 않도록 비워준다.
		session.invalidate();
		//메시지와 이동할 경로 저장
		mav.addObject("message", "good-bye");
		mav.setViewName("redirect:/waffleMember/login.do");
		//로그인 페이지로 이동
		return mav;
	}
}
