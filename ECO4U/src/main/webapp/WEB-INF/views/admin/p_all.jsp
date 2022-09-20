<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/product.js"></script>

<h2>전체 상품 조회</h2>
<div class="sub-menu">
	<ul>
		<li><a href="admin_plist.do">전체상품 조회</a>
		<li><a href="admin_write.do">상품등록</a>
	</ul>
	
	<form id="search_form" action="admin_plist.do" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>카테고리</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>상품명</option>
					<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>브랜드</option>
				</select>
			</li>
			
			<li>
				<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			
			<li>
				<input type="submit" value="검색">
			</li>
		</ul>
	</form>
	
	<div class="align-right">
		<input type="button" value="등록" onclick="location.href='admin_write.do'">
		<input type="button" value="목록" onclick="location.href='admin_plist.do'">
	</div>
	
	<c:if test="${count == 0}">
		<div class="result-display">표시할 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table>
			<tr>
				<th>번호</th>
				<th>카테고리</th>
				<th>브랜드</th>
				<th>상품명</th>
				<th>가격</th>
				<th>재고수</th>
				<th>등록일</th>
				<th>상태</th>
			</tr>
			
			<c:forEach var="product" items="${list}">
			<tr>
				<td>${product.p_num}</td>
				<td>
					<c:if test="${product.p_category == 1}">Living</c:if>
					<c:if test="${product.p_category == 2}">Beauty</c:if>
					<c:if test="${product.p_category == 3}">Fashion</c:if>
				</td>
				<td>${product.p_brand}</td>
				<td><a href="admin_pdetail.do?p_num=${product.p_num}">${product.p_name}</a></td>
				<td><fmt:formatNumber value="${product.p_price}"/></td>
				<td><fmt:formatNumber value="${product.p_quantity}"/></td>
				<td>${product.reg_date}</td>
				<td>
					<c:if test="${product.p_status == 1}">표시</c:if>
					<c:if test="${product.p_status == 2}">미표시</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">
			${page}
		</div>
	</c:if>
	
</div>
<!-- 내용 끝 -->