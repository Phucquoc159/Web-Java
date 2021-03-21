<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Quản lý đơn hàng</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
body {
	font-family: "Lato", sans-serif;
}

.sidebar {
	height: 100%;
	width: 200px;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	background-color: #dc3545 !important;
	overflow-x: hidden;
	padding-top: 16px;
}

.sidebar a {
	padding: 6px 8px 6px 16px;
	text-decoration: none;
	font-size: 17px;
	color: #ffffff;
	display: block;
}

.admin {
	padding: 6px 8px 6px 16px;
	text-decoration: none;
	font-size: 17px;
	color: #ffffff;
	display: block;
}

.sidebar a:hover {
	background-color: #9e1623;
}

.main {
	margin-left: 200px; /* Same as the width of the sidenav */
	padding: 0px 10px;
}

@media screen and (max-height: 450px) {
	.sidebar {
		padding-top: 15px;
	}
	.sidebar a {
		font-size: 18px;
	}
}
</style>
</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<div class="sidebar">
			<a href="admin/home.htm"><i class="fas fa-user-shield"></i> ${sessionScope.admin.getLastname()} ${sessionScope.admin.getFirstname()}</a>
			<hr>
			<a href="admin/product/index.htm"><i class="fas fa-motorcycle"></i> Quản lý xe</a> 
			<a href="admin/product/insert.htm"><i class="fas fa-plus-square"></i> Thêm sản phẩm mới</a> 
			<a href="admin/ad/index.htm"><i class="fas fa-ad"></i> Quản lý quảng cáo</a> 
			<a href="admin/ad/insert.htm"><i class="fas fa-plus-square"></i> Thêm quảng cáo</a> 
			<a href="admin/orders.htm"><i class="fas fa-clipboard-list"></i> Quản lý đơn hàng</a>
			<a href="admin/users.htm"><i class="fas fa-users"></i> Khách hàng</a>
	</div>

	<div class="main">
		<div class="container">
			<br>
			<h3>QUẢN LÝ ĐƠN HÀNG</h3>
			<div>
				<table class="table table-bordered table-hover table-condensed">
					<thead>
						<tr>
							<th>Mã ĐH</th>
							<th>Ngày mua</th>
							<th>Khách hàng</th>
							<th>Số ĐT</th>
							<th>Tên sản phẩm</th>
							<th>Giá tiền</th>
							<th>SL</th>
							<th>Địa chỉ giao hàng</th>
							<th>Ghi chú</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="o" items="${orders}">
							<tr>
								<td width="50px">${o.idOrder}</td>
								<td width="110px"><f:formatDate pattern="dd-MM-yyyy" value="${o.date}"/></td>
								<td width="150px">${o.user.getLastname()} ${o.user.getFirstname()}</td>
								<td>${o.user.getPhone()}</td>
								<td width="150px">${o.product.name}</td>
								<td width="130px"><f:formatNumber minFractionDigits = "0" value="${o.product.price}" type="number"/> ₫</td>
								<td width="60px">${o.amount}</td>
								<td width="250px">${o.deliveryAddress}</td>
								<td width="100px">${o.note}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
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