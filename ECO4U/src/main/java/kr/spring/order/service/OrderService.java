package kr.spring.order.service;

import java.util.List;
import java.util.Map;

import kr.spring.order.vo.OrderVO;
import kr.spring.zipcode.vo.ZipcodeVO;

public interface OrderService {
	//대표 배송지 조회 출력
	public ZipcodeVO selectZipcode(Integer mem_num);
	//배송시 요청사항 저장
	public void insertNotice(OrderVO order);
	//배송지 리스트
	public List<ZipcodeVO> selectZipList(Map<String,Object> map);
	//배송지 카운트
	public int selectZipRowCount(Map<String,Object> map, Integer mem_num);
	
	public void updateZipcode(ZipcodeVO zipcode);

	public void insertOrder(OrderVO order);

	public OrderVO selectOrder(Integer mem_num);



}

