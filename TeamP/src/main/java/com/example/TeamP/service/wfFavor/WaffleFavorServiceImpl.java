package com.example.TeamP.service.wfFavor;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.TeamP.model.wfFavor.dao.WaffleFavorDAO;
import com.example.TeamP.model.wfFavor.dto.WaffleFavorDTO;

@Service
public class WaffleFavorServiceImpl implements WaffleFavorService {
	
	//의존관계 주입
	@Inject
	WaffleFavorDAO wfFavorDao;
	
	//찜목록 출력
	@Override
	public List<WaffleFavorDTO> list(String userid) {
		return wfFavorDao.list(userid);
	}
	
	//찜 추가
	@Override
	public void insert(WaffleFavorDTO dto) {
		wfFavorDao.insert(dto);
	}
	
	//찜 삭제
	@Override
	public void delete(WaffleFavorDTO dto) {
		wfFavorDao.delete(dto);
	}
}
