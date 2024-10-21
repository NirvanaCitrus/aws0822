package mvc.vo;


// 페이지 하단에 페이징 네비게이션에 필요한 변수들을 담아놓은 클래스
public class PageMaker {
	
	private int displayPageNum=10;  // 페이지 목록번호 리스트  1 2 3 4 5 6 7 8 9 <= 하단에 이렇게 나타나는 목록
	private int startPage;  // 목록의 시작번호를 담는 변수
	private int endPage; // 목록의 끝 번호를 담는 변수
	private int totalCount;  // 총 게시물 수를 담는 변수
	
	private boolean prev;  // 이전 버튼
	private boolean next;  // 다음 버튼
	
	private Criteria cri;

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {  // 총 게시물이 몇개인지 받는 메소드
		this.totalCount = totalCount;
		calcData();  // 페이지 목록 리스트 번호를 나타내주기 위한 계산식 
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	private void calcData() {
		
		// 1. 기본적으로 1에서부터 10까지 나타나게 설정한다. (페이지네비게이션)
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum); 
		// 모두 올림처리하는 메소드 ceil().
		
		// 2. endPage가 설정되었으면 시작페이지도 설정.
		startPage = (endPage - displayPageNum)+1;  // endPage에서 displayPageNum을 빼고 1을 더한다. 
		
		// 3. 실제 게시물수에 따라서 endPage를 구하겠다.
		int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));  // 실제 리스트를 가져와서 15개로 나누어서 올림처리
		
		// 4. 설정한 endPage와 실제 endPage를 비교해서 최종 endPage 구한다.
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
			
		}
		
		// 5. 이전다음 버튼 만들기
		prev = (startPage == 1 ? false : true);   // 삼항연산자 사용
		next = (endPage*cri.getPerPageNum() >= totalCount ? false:true);
		
		
		
	}
	
	
	
	
	
	

}
