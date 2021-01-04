/**	views/include/js/common.js
 * 	정규표현식 : /jpg|gif|png|jpeg/
 */
function checkImageType(fileName) {
	var pattern=/jpg|gif|png|jpeg/;
	return fileName.match(pattern);
}
function getFileInfo(fullName) {
	var fileName, imgsrc, getLink, fileLink;
	if(checkImageType(fullName)){// 이미지 파일인 경우
		imgsrc = "/TeamP/upload/displayFile?fileName="+fullName;
		fileLink=fullName.substr(14);	//14인덱스 ~ 끝
		var front=fullName.substr(0,12);	//0~11
		var end=fullName.substr(14);
		getLink="/TeamP/upload/displayFile?fileName="+front+end;		
	} else {//이미지가 아닌 경우
		fileLink=fullName.substr(12);
		getLink="/TeamP/upload/displayFile?fileName="+fullName;
	}
	//uuid_filename (+1은 _ 다음의 filename을 뽑아냄)
	fileName=fileLink.substr(fileLink.indexOf("_")+1);
	//json 리턴
	return {fileName : fileName, imgsrc: imgsrc, getLink: getLink, fullName: fullName};
}