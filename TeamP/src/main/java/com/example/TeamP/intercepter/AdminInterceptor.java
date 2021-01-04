package com.example.TeamP.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {

	//메인 액션 실행되기 전 작동(전처리)
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//세션 객체 생성
		HttpSession session=request.getSession();
		//세션이 없으면(로그인되지 않은 상태)
		if(session.getAttribute("admin_userid") == null) {
			//views/member/login.jsp 페이지로 이동하면서 nologin메시지를 전송
			response.sendRedirect(request.getContextPath()+"/waffleContent/main_view.do?message=noadmin");
			return false;	//메인 액션으로 가지 않음
		} else {
			return true;	//메인 액션으로 이동
		}
	}//preHandle()
	
	//메인 액션이 실행된 이후에 작동(후처리)
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}
