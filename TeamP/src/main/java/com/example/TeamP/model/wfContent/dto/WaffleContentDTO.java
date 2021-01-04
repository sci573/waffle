package com.example.TeamP.model.wfContent.dto;

public class WaffleContentDTO {
	private int cno;			//작품 번호
	private String title;		//제목
	private String genre;		//장르
	private String category;	//카테고리(영화/드라마)
	private String poster;		//포스터(사진)
	private String rated;		//등급(몇세)
	private String cast;		//출연진(캐스트)
	private String year;		//제작년도
	private String description;	//줄거리
	//getter,setter,toString,기본생성자
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getRated() {
		return rated;
	}
	public void setRated(String rated) {
		this.rated = rated;
	}
	public String getCast() {
		return cast;
	}
	public void setCast(String cast) {
		this.cast = cast;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "WaffleContentDTO [cno=" + cno + ", title=" + title + ", genre=" + genre + ", category=" + category
				+ ", poster=" + poster + ", rated=" + rated + ", cast=" + cast + ", year=" + year + ", description="
				+ description + "]";
	}
	//기본 생성자
	public WaffleContentDTO() {
		
	}
}
