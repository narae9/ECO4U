<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/cart.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
<script type="text/javascript">
function checkSelectAll()  {
	  // 전체 체크박스
	  const checkboxes 
	    = document.querySelectorAll('input[name="select_product"]');
	  // 선택된 체크박스
	  const checked 
	    = document.querySelectorAll('input[name="select_product"]:checked');
	  // select all 체크박스
	  const selectAll 
	    = document.querySelector('input[name="selectall"]');
	  
	  if(checkboxes.length === checked.length)  {
	    selectAll.checked = true;
	  }else {
	    selectAll.checked = false;
	  }
}

function selectAll(selectAll)  {
	  const checkboxes 
	     = document.getElementsByName('select_product');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	  })
}
</script>
<div class="page-main">
	<div class="cart-top">
		<div class="cart-left">장바구니</div>
		<div class="cart-right"><b>장바구니</b> > 주문/결제 > 주문완료</div>
	</div>
	<c:if test="${empty list}">
	<div class="result-display">
		장바구니에 담은 상품이 없습니다.
	</div>
	</c:if>
	<c:if test="${!empty list}">
	<div class="cart-choice">
	<span><input type="checkbox" id="selectall" name="selectall"
	 value="전체 선택"  onclick="selectAll(this)">전체 선택</span>
	<span> | <input type="button" value="선택 삭제" id="delete_btn"></span> 
	</div>
	
	<div class="content">
		<div class="content1">
		<ul class="cart-list-ul">
			<c:forEach var="cart" items="${list}">
			<div class="content-main">
			<li class="cart-list-li">
				<div class="box-parent">
					<input type="hidden" value="${cart.productVO.p_category}">
					<input type="hidden" value="${cart.mem_num}">
					<input type="hidden" value="${cart.cart_num}">
					<input type="hidden" value="${cart.p_num}">
					<input type="hidden" value="${cart.productVO.p_status}">
					
					<div class="div1">
						<div class="check-box">
							<input type="checkbox" class="select-product" name="select_product" 
							 onclick="checkSelectAll()" data-cartnum="${cart.cart_num}" value="${cart.cart_num}">
						 </div>
						<div class="box-brand">[${cart.productVO.p_brand}]</div>
					</div>
					
					<hr color="gray" width="95%" size="1">
					
					<div class="div2-parent">
						<div class="div2">
							<div class="product-image">
							<a href="${pageContext.request.contextPath}/product/detail.do?p_num=${cart.p_num}">
								<img src="../images/product/${cart.productVO.p_photoname}" width="80" height="80">
							</a>
							</div>
							<div class="product-box">
								<a href="${pageContext.request.contextPath}/product/detail.do?p_num=${cart.p_num}">
								<span class="box-title">${cart.productVO.p_name}</span><br>
								</a>
								<span class="box-price"><strong>${cart.productVO.p_price}</strong></span>
							</div>
							
						</div>
						<div class="div2-1">
	                        <c:if test="${cart.productVO.p_status == 2 or cart.productVO.p_quantity < cart.order_quantity}">[판매중지]</c:if>
							<c:if test="${cart.productVO.p_status == 1 and cart.productVO.p_quantity >= cart.order_quantity}">
								<button class="minus">-</button>
								<input type="number" name="order_quantity" min="1" max="99999" 
								value="${cart.order_quantity}" class="quantity-width">
								<button class="plus">+</button>
								<br>
								<input type="button" value="변경" class="cart-modify"
								data-cartnum="${cart.cart_num}" data-pmnum="${cart.p_num}">
							</c:if>
	                    </div>
	                    <div class="div2-2">
								<input type="button" value="X" class="delete-pro" data-cartnum="${cart.cart_num}">
						</div>
                    </div>
                    
					<div class="div3">
						<div class="cart-bottom-price">
							<span>상품금액</span><br>
							<div class="price-span">${cart.productVO.p_price}</div>
						</div>
						<span class="span-sym">-</span>
						<div class="cart-bottom-price">
							<span>할인금액</span><br>
							<div class="price-span sale">0</div>
						</div>
						<span class="span-sym">+</span>
						<div class="cart-bottom-price">
							<span>배송비</span><br>
							<div class="price-span">${cart.productVO.p_dprice}</div>
						</div>
						<span class="span-sym">=</span>
						<div class="cart-bottom-price">
							<span>주문금액</span><br>
							<div id="item_total" class="price-span">${cart.cart_total}</div>
						</div>
					</div>
				</div>
			</li>
			</div>
			</c:forEach>
		</ul>
		</div> <!-- end of content1 -->
		<script type="text/javascript">
			$('.delete-pro').click(function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
			        let del_btn = $(this).attr('data-cartnum');
					location.replace('delete.do?cart_num='+del_btn);
				}
				
			});
			
		</script> 
		
		<div class="content2">
			<span>결제정보</span>
			<hr color="gray" width="95%" size="1">
			<br>
			<div class="order-info">
				<table class="order-info-table">
					<tr>
						<td>상품수</td>
						<td>${count}개</td>
					</tr>
					<tr>
						<td>상품금액</td>
						<td>${all_total}원</td>
					</tr>
					<tr>
						<td>할인금액</td>
						<td>0원</td>
					</tr>
					<tr>
						<td>배송비</td>
						<td>${cart.productVO.p_dprice}원</td>
					</tr>
				</table>
				<hr color="gray" width="95%" size="1">
				<div class="order-total">
					<table>
						<tr>
							<td>총 결제금액</td>
							<td>${all_total + cart.productVO.p_dprice}</td>
						</tr>
					</table>
				</div>
			</div>
			
			
			<div class="cart-order">
			<input type="button" value="결제하기" onclick="location.href='orders.do'">
			</div>
		</div>
		
		
	</div> <!-- end of content -->
	</c:if>
		
	
</div>

<!-- 내용 끝 -->