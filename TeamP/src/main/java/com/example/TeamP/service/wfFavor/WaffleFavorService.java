package com.example.TeamP.service.wfFavor;

import java.util.List;

import com.example.TeamP.model.wfFavor.dto.WaffleFavorDTO;

public interface WaffleFavorService {
	public List<WaffleFavorDTO> list(String userid);
	public void insert(WaffleFavorDTO dto);
	public void delete(WaffleFavorDTO dto);

}
