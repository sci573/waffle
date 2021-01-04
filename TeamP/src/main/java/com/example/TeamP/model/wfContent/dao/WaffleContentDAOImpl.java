package com.example.TeamP.model.wfContent.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.TeamP.model.wfContent.dto.WaffleCommentDTO;
import com.example.TeamP.model.wfContent.dto.WaffleContentDTO;

@Repository
public class WaffleContentDAOImpl implements WaffleContentDAO {

	//의존관계 주입
	@Inject
	SqlSession sqlSession;
	
	//영화 카테고리
	@Override
	public List<WaffleContentDTO> movie() {//하단 영화 전체
		return sqlSession.selectList("content.movie");
	}
	@Override public List<WaffleContentDTO> movie_action() { 
		return sqlSession.selectList("content.movie_action"); 
	}
	@Override
	public List<WaffleContentDTO> movie_thriller() {
		return sqlSession.selectList("content.movie_thriller");
	}
	@Override
	public List<WaffleContentDTO> movie_romance() {
		return sqlSession.selectList("content.movie_romance");
	}
	@Override public List<WaffleContentDTO> movie_comedy() { 
		return sqlSession.selectList("content.movie_comedy"); 
	}
	@Override public List<WaffleContentDTO> movie_sf() { 
		return sqlSession.selectList("content.movie_sf"); 
	}

	//드라마 카테고리
	@Override
	public List<WaffleContentDTO> drama() {//하단 드라마 전체
		return sqlSession.selectList("content.drama");
	}
	@Override public List<WaffleContentDTO> drama_action() { 
		return sqlSession.selectList("content.drama_action"); 
	}
	@Override
	public List<WaffleContentDTO> drama_thriller() {
		return sqlSession.selectList("content.drama_thriller");
	}
	@Override
	public List<WaffleContentDTO> drama_romance() {
		return sqlSession.selectList("content.drama_romance");
	}
	@Override public List<WaffleContentDTO> drama_comedy() { 
		return sqlSession.selectList("content.drama_comedy"); 
	}
	@Override public List<WaffleContentDTO> drama_sf() { 
		return sqlSession.selectList("content.drama_sf"); 
	}

	//중복 컨텐츠 필터링 작업을 추천 컨텐츠 반환
	@Override
	public String list_reco_all(int cno) {
		return sqlSession.selectOne("content.listRecoAll",cno);
	}
	
	//중복 제거된 추천 컨텐츠 반환
	@Override
	public WaffleContentDTO list_reco(String title) {
		return sqlSession.selectOne("content.listReco",title);
	}
	
	//추천 컨텐츠 service에 반환될 전체 content row 갯수
	@Override
	public int countAll() {
		return sqlSession.selectOne("content.countAll");
	}
	
	//전체 컨텐츠 반환 (랜덤 리스트)
	@Override
	public List<WaffleContentDTO> list_all() {
		return sqlSession.selectList("content.listAll");
	}
	
	//컨텐츠 디테일 view
	@Override
	public WaffleContentDTO detailCont(String title) {
		return sqlSession.selectOne("content.detail", title);
	}
	
	//관리자 디테일 수정
	@Override
	public void admin_edit(WaffleContentDTO dto) {
		sqlSession.update("content.admin_edit", dto);		
	}
	
	//관리자 디테일 삭제
	@Override
	public void admin_delete(String title) {
		sqlSession.delete("content.admin_delete", title);
	}
	
	//삭제 후 번호 갱신을 위해 해당 타이틀의 번호 받아오기
	@Override
	public int get_cno(String title) {
		return sqlSession.selectOne("content.get_cno", title);
	}
	
	//번호 갱신
	@Override
	public void updateNum(List<Integer> cno_list) {
		sqlSession.update("content.updateNum", cno_list);
	}
	
	//관리자 디테일 댓글 삭제
	@Override
	public void admin_delete_re(String title) {
		sqlSession.delete("content.admin_delete_re",title);
	}
	
	//관리자 디테일 삽입
	@Override
	public void admin_insert(WaffleContentDTO dto) {
		sqlSession.insert("content.admin_insert",dto);
	}
	
	//댓글 리스트
	@Override
	public List<WaffleCommentDTO> comment_list(String title) {
		return sqlSession.selectList("content.comment_list", title);
	}
	
	//댓글 추가
	@Override
	public void comment_add(WaffleCommentDTO dto) {
		sqlSession.insert("content.comment_add", dto);
	}
	
	//댓글 삭제
	@Override
	public void comment_dlt(WaffleCommentDTO dto) {
		sqlSession.delete("content.comment_dlt", dto);
	}
	
	//컨텐츠 유무 확인
	@Override
	public int countContent(String title, String userid) {
		Map<String, String> map=new HashMap<>();
		map.put("title", title);
		map.put("userid", userid);
		return sqlSession.selectOne("content.countContent", map);
	}
	
	//검색 기능
	@Override
	public List<WaffleContentDTO> search(List<String> inputArr) {
		//새로 List를 생성하여 요소를 저장해줌
		List<WaffleContentDTO> inputList=new ArrayList<>();
		
		//row리스트를 저장할 셋 생성
		//Set<Set<WaffleContentDTO>> list=new HashSet<Set<WaffleContentDTO>>();
		//Set<WaffleContentDTO> list=new HashSet<WaffleContentDTO>();
		
		//row리스트를 저장할 리스트 생성
		List<WaffleContentDTO> list=new ArrayList<WaffleContentDTO>();
		
		//title로 중복되는 게시물을 걸러내기 위해 Set사용
		Set<String> titleList=new HashSet<>();
		
		//inputArr에 존재하는 요소의 갯수만큼 selectOne문을 실행
		for(int i=0; i<inputArr.size(); i++) {
			String input="%"+inputArr.get(i)+"%";
			//input(검색 키워드)와 일치하는 값이 존재하는 row리스트 출력
			inputList=sqlSession.selectList("content.search_all", input);
			
			//for-each문으로 List에 있는 dto의 title값을 하나씩 받아오기
			for(WaffleContentDTO dto : inputList) {
				//title을 Set 객체인 titleList에 하나씩 추가
				titleList.add(dto.getTitle());
			}
			
			/* 중복제거에 실패한 소스...
			//list인 inputList를 Set으로 변환(중복 방지 목적)
			Set<WaffleContentDTO> put_list=new HashSet<>(inputList);
			//Iterator를 이용해서 put_list에 저장되어 있는 요소들을 읽어오기 위해 객체 선언.(1차 중복제거)
			Iterator<WaffleContentDTO> read=put_list.iterator();
			//필터링된(1차 중복제거가 된) 데이터를 담기 위한 set
			Set<WaffleContentDTO> get_list=new HashSet<>();
			
			//1차 중복 제거
			while(read.hasNext()) {
				WaffleContentDTO plus_list=read.next();
				System.out.println("읽어온값:"+plus_list);
				get_list.add(plus_list);
			}
			
			//1차 중복제거가 되어 get_list에 담겨진 데이터를 받아와서 2차 중복제거를 해줘야한다.
			Set<Set<WaffleContentDTO>> put_all_list=new HashSet<>();
			put_all_list.add(get_list);
			//Iterator를 이용해서 put_all_list에 저장되어 있는 요소들을 읽어오기 위해 객체 선언.(2차 중복제거)
			Iterator<Set<WaffleContentDTO>> read_all=put_all_list.iterator();
			//전체 필터링된(2차 중복제거가 된) 데이터를 담기 위한 set
			Set<Set<WaffleContentDTO>> get_all_list=new HashSet<Set<WaffleContentDTO>>();
			
			//2차 중복 제거
			while(read_all.hasNext()) {
				Set<WaffleContentDTO> plus_list_all=read_all.next();
				System.out.println("읽어온값2:"+plus_list_all);
				get_all_list.add(plus_list_all);				
			}
			
			//중복제거가 완료된 set을 반환할 변수 list.
			list.addAll(get_all_list);
			*/
		}
		//title이 중복되었는지 확인
		System.out.println("중복확인:");
		for(String title : titleList) {
			System.out.println(title);
			//DB에서 해당되는 타이틀를 가진 데이터 가져오기
			WaffleContentDTO dto=sqlSession.selectOne("content.search", title);
			list.add(dto);
		}
		//inputList 반환
		return list;
	}
}
