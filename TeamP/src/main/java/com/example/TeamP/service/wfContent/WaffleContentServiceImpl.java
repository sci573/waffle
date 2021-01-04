package com.example.TeamP.service.wfContent;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.TeamP.model.wfContent.dao.WaffleContentDAO;
import com.example.TeamP.model.wfContent.dto.WaffleCommentDTO;
import com.example.TeamP.model.wfContent.dto.WaffleContentDTO;

@Service
public class WaffleContentServiceImpl implements WaffleContentService {
	
	//의존관계 주입
	@Inject
	WaffleContentDAO wfContDao;
	
	//영화 카테고리
	@Override
	public List<WaffleContentDTO> movie() {//하단 영화 전체
		List<WaffleContentDTO> list=wfContDao.movie();
		return list;
	}
	
	@Override
	public List<WaffleContentDTO> movie_action() {
		List<WaffleContentDTO> list=wfContDao.movie_action();
		return list;
	}
	@Override
	public List<WaffleContentDTO> movie_thriller() {
		List<WaffleContentDTO> list=wfContDao.movie_thriller();
		return list;
	}
	@Override
	public List<WaffleContentDTO> movie_romance() {
		List<WaffleContentDTO> list=wfContDao.movie_romance();
		return list;
	}
	@Override
	public List<WaffleContentDTO> movie_comedy() { 
		List<WaffleContentDTO> list=wfContDao.movie_comedy();
		return list; 
	}
	@Override
	public List<WaffleContentDTO> movie_sf() { 
		List<WaffleContentDTO> list=wfContDao.movie_sf(); 
		return list; 
	}
		
	//드라마 카테고리
	@Override
	public List<WaffleContentDTO> drama() {//하단 드라마 전체
		List<WaffleContentDTO> list=wfContDao.drama(); 
		return list;
	}
	
	@Override
	public List<WaffleContentDTO> drama_action() {
		List<WaffleContentDTO> list=wfContDao.drama_action(); 
		return list; 
	}
	@Override
	public List<WaffleContentDTO> drama_thriller() {
		List<WaffleContentDTO> list=wfContDao.drama_thriller(); 
		return list; 
	}
	@Override
	public List<WaffleContentDTO> drama_romance() {
		List<WaffleContentDTO> list=wfContDao.drama_romance(); 
		return list; 
	}
	@Override
	public List<WaffleContentDTO> drama_comedy() {
		List<WaffleContentDTO> list=wfContDao.drama_comedy(); 
		return list; 
	}
	@Override
	public List<WaffleContentDTO> drama_sf() {
		List<WaffleContentDTO> list=wfContDao.drama_sf(); 
		return list; 
	}
	
	//추천 컨텐츠 (랜덤으로 띄우기)
	@Override
	public List<WaffleContentDTO> list_reco() {
		//랜덤함수 생성(랜덤으로 10개를 받아온다)
		int repeat=10;

		//ArrayList생성
		List<WaffleContentDTO> list=new ArrayList<>();
		
		//중복 방지를 위해 Set 객체 이용
		//횟수 반복을 위한 set
		Set<Integer> defend=new HashSet<>();
		//title, poster의 중복을 제거하기 위한 set
		Set<String> listAll=new HashSet<>();
		
		//content 테이블의 총 row 갯수 알아오기
		int count=wfContDao.countAll();
		
		//Set객체인 defend의 길이와 repeat(반복 횟수)가 동일해질 때 종료
		do {
			//랜덤 수 생성
			Random rand=new Random();
			//1 ~ 총 갯수 까지
			int cno=rand.nextInt(count)+1;
			
			/* 중복 방지를 위한 코드 */
			//랜덤번호를 Set에 추가
			defend.add(cno);
			//랜덤번호 확인
			System.out.println("번호"+cno+"\n사이즈"+defend.size());
		} while(defend.size()<repeat);
		
		//Set에 입력된 번호 출력
		//Iterator를 이용해서 출력해야한다
		Iterator<Integer> cno_list=defend.iterator();
		while(cno_list.hasNext()) {
			//번호를 int 변수에 대입
			int cno=cno_list.next();
			System.out.println(cno);
			//cno변수의 값에 해당되는 제목 DB에서 불러오기
			String listReco=wfContDao.list_reco_all(cno);
			System.out.println(listReco);
			//추천 컨텐츠 타이틀을 Set에 추가
			listAll.add(listReco);
		}
		//Set 객체인 defend 초기화
		defend.clear();
		
		//불러온 리스트 중에서 중복된 title이 존재하는지 확인
		System.out.println("----중복확인----");
		//Set에 입력된 title 출력
		//Iterator를 이용해서 출력해야한다
		Iterator<String> title_list=listAll.iterator();
		while(title_list.hasNext()) {
			//제목을 String 변수에 대입
			String title=title_list.next();
			System.out.println(title);
			//title변수의 값에 해당되는 제목과 포스터 DB에서 불러오기
			WaffleContentDTO dto=wfContDao.list_reco(title);
			list.add(dto);
		}
		//list 반환
		return list;
	}
	
	//전체 컨텐츠 (랜덤으로 띄우기)
	@Override
	public List<WaffleContentDTO> list_all() {
		List<WaffleContentDTO> list=wfContDao.list_all();
		//list 반환
		return list;
	}
	
	//컨텐츠 디테일 view
	@Override
	public WaffleContentDTO detailCont(String title) {
		WaffleContentDTO dto=wfContDao.detailCont(title);
		return dto;
	}
	
	//댓글 리스트
	@Override
	public List<WaffleCommentDTO> comment_list(String title) {
		List<WaffleCommentDTO> comment_list=wfContDao.comment_list(title);
		return comment_list;
	}

	//댓글 추가
	@Override
	public void comment_add(WaffleCommentDTO dto) {
		wfContDao.comment_add(dto);
	}
	
	//댓글 삭제
	@Override
	public void comment_dlt(WaffleCommentDTO dto) {
		wfContDao.comment_dlt(dto);
	}
	
	//컨텐츠 유무 확인
	@Override
	public int countContent(String title, String userid) {
		return wfContDao.countContent(title,userid);
	}
	
	//관리자 디테일 수정
	@Override
	public void admin_edit(WaffleContentDTO dto) {
		wfContDao.admin_edit(dto);
	}
	
	//관리자 디테일 삭제
	//ORA-12519에러가 발생하기 때문에 관리자 계정으로 DB에 접속 후
	//ALTER system SET processes=(여유있는 프로세스 설정 값) scope=spfile;
	//쿼리문을 입력하여 수정 후 이용해야함. (DB에 접속하는 프로세스의 수가 설정값보다 많아서 발생하는 에러이다.)
	//참조 : https://luckybaby.tistory.com/70
	//참조 : https://jun7222.tistory.com/310
	//--> 다른 방법으로 수정함 (mapper에서 foreach문 사용)
	@Transactional
	@Override
	public void admin_delete(String title) {
		//컨텐츠가 삭제되면 번호를 갱신해줘야한다.
		//list_reco에 랜덤번호에 해당되는 cno의 반환 dto 값이 null으로 처리돼서 컨텐츠가 뜨지 않는 경우가 생길 수 있다
		
		//해당 타이틀의 cno값 받아오기
		int cno=wfContDao.get_cno(title);
		//cno값을 받아온 후 타이틀에 해당되는 row 삭제처리
		wfContDao.admin_delete(title);
		
		//삭제 후 게시물 번호 수정 코드
		//게시물마다 cno의 값을 갱신하기 위해서 list를 생성한다.(mapper에서 배열 또는 list형식으로 데이터를 받아야 한다.)
		List<Integer> cno_list=new ArrayList<Integer>();
		
		//content 테이블의 총 row 갯수 알아오기 (하나가 삭제되어서 기존의 갯수보다 -1개가 반환된다)
		int count=wfContDao.countAll();
		
		//list에 삭제한 게시물의 번호부터 끝 번호까지 cno 값 저장
		for(int i=cno; i<=count+1; i++) {
			cno_list.add(i);
		}
		//번호 갱신
		wfContDao.updateNum(cno_list);
	}
	
	//관리자 디테일 댓글 삭제
	@Override
	public void admin_delete_re(String title) {
		wfContDao.admin_delete_re(title);
	}
	
	//관리자 디테일 삽입
	@Override
	public void admin_insert(WaffleContentDTO dto) {
		wfContDao.admin_insert(dto);
	}	

	//검색 기능
	@Override
	public List<WaffleContentDTO> search(List<String> inputArr) {
		List<WaffleContentDTO> list=wfContDao.search(inputArr); 
		return list; 
	}
}
