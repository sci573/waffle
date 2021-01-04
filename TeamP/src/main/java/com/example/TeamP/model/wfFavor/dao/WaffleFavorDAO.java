package com.example.TeamP.model.wfFavor.dao;

import java.util.List;

import com.example.TeamP.model.wfFavor.dto.WaffleFavorDTO;

public interface WaffleFavorDAO {
	public List<WaffleFavorDTO> list(String userid);
	public void insert(WaffleFavorDTO dto);
	public void delete(WaffleFavorDTO dto);

}
