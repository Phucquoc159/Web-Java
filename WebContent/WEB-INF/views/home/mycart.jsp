<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GIỎ HÀNG CỦA TÔI</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<div style="background-color: #dc3545; width: 100%; height: 50px; margin-bottom: 40px;">
			<p style="padding-top: 12px; padding-left: 24px; font-size: 17px;">
				<a href="home/index.htm" style="color: white;">
					<i class="fas fa-arrow-left"></i> Quay về trang chủ
				</a>
			</p>
	</div>
	<h3 style="text-align: center;">Đơn hàng của tôi</h3>
	<hr style="border-top: 2px solid red; margin-left: 40px; margin-right: 40px">
	<div style="margin-left: 50px; margin-right: 50px">
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>Mã ĐH</th>
					<th>Ngày mua</th>
					<th>Tên sản phẩm</th>
					<th>Giá tiền</th>
					<th>Số lượng</th>
					<th>Thành tiền</th>
					<th>Địa chỉ giao hàng</th>
					<th>Ghi chú</th>
					<th>Trạng thái</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="o" items="${orders}">
					<tr>
						<td width="50px">${o.idOrder}</td>
						<td width="110px"><f:formatDate pattern="dd-MM-yyyy" value="${o.date}"/></td>
						<td>${o.product.name}</td>
						<td width="130px"><f:formatNumber minFractionDigits = "0" value="${o.product.price}" type="number"/> ₫</td>
						<td width="100px">${o.amount}</td>
						<td width="130px"><f:formatNumber minFractionDigits = "0" value="${o.product.price * o.amount}" type="number"/> ₫</td>
						<td>${o.deliveryAddress}</td>
						<td width="200px">${o.note}</td>
						<td style="color: green;" width="130px">Thành công</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 	thư viện    -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/66b27f5cfd.js"
		crossorigin="anonymous"></script>
</body>
</html>