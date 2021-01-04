package com.example.TeamP.model.wfFavor.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.TeamP.model.wfFavor.dto.WaffleFavorDTO;

@Repository
public class WaffleFavorDAOImpl implements WaffleFavorDAO {
	
	//의존관계 주입
	@Inject
	SqlSession sqlSession;
	
	//찜 목록 출력
	@Override
	public List<WaffleFavorDTO> list(String userid) {
		return sqlSession.selectList("favor.list", userid);
	}
	
	//찜 추가
	@Override
	public void insert(WaffleFavorDTO dto) {
		sqlSession.insert("favor.insert", dto);
	}
	
	//찜 삭제
	@Override
	public void delete(WaffleFavorDTO dto) {
		sqlSession.delete("favor.delete", dto);
	}
}
