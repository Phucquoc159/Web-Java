<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Quản lý sản phẩm</title>
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
			<h3>QUẢN LÝ DANH MỤC XE CỦA BẠN</h3>
			
			<c:forEach var="b" items="${brands}">
				<div style="margin-bottom: 10px; margin-top: 30px">
					<img src="./images/logo/${b.logo}"
						style="height: 30px; margin-left: 20px;"> <b>${b.name}</b>
				</div>
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>Mã xe</th>
							<th>Tên xe</th>
							<th>Số lượng</th>
							<th>Giá tiền</th>
							<th>Hãng xe</th>
							<th>Thao tác</th>
							<th>Thao tác</th>
							<th>Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${products}">
							<c:if test="${p.brand.name == b.name}">
								<tr>
									<td>${p.id}</td>
									<td width="300px">${p.name}</td>
									<td width="99px">${p.amount}</td>
									<td width="140px"><f:formatNumber minFractionDigits = "0" value="${p.price}" type="number"/> ₫</td>
									<td width="99px">${p.brand.name}</td>
									<td width="99px"><a href="admin/product/edit/${p.id}.htm">Chỉnh sửa</a></td>
									<td width="92px"><a href="admin/product/delete/${p.id}.htm">Xóa</a></td>
									<td width="102px"><a href="admin/product/${p.id}.htm">Xem trước</a></td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
				<hr>	
			</c:forEach>
			
		</div>
	</div>
			
<%-- 			<div style="margin-bottom: 10px; margin-top: 20px">
				<img src="./images/logo/honda.jpg"
					style="height: 30px; margin-left: 20px;"> <b>HONDA</b>
			</div>
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>Mã xe</th>
						<th>Tên xe</th>
						<th>Số lượng</th>
						<th>Giá tiền</th>
						<th>Hãng xe</th>
						<th>Thao tác</th>
						<th>Thao tác</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${products}">
						<c:if test="${p.brand.name == 'HONDA'}">
						<tr>
							<td>${p.id}</td>
							<td width="300px">${p.name}</td>
							<td width="99px">${p.amount}</td>
							<td width="140px"><f:formatNumber minFractionDigits = "0" value="${p.price}" type="number"/> ₫</td>
							<td width="99px">${p.brand.name}</td>
							<td width="99px"><a href="admin/product/edit/${p.id}.htm">Chỉnh sửa</a></td>
							<td width="92px"><a href="admin/product/delete/${p.id}.htm">Xóa</a></td>
							<td width="102px"><a href="admin/product/${p.id}.htm">Xem trước</a></td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			
			<div style="margin-bottom: 10px; margin-top: 40px">
				<img src="./images/logo/yamaha.png"
					style="height: 30px; margin-left: 20px;"> <b>YAMAHA</b>
			</div>
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>Mã xe</th>
						<th>Tên xe</th>
						<th>Số lượng</th>
						<th>Giá tiền</th>
						<th>Hãng xe</th>
						<th>Thao tác</th>
						<th>Thao tác</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${products}">
						<c:if test="${p.brand.name == 'YAMAHA'}">
						<tr>
							<td>${p.id}</td>
							<td width="300px">${p.name}</td>
							<td width="99px">${p.amount}</td>
							<td width="140px"><f:formatNumber minFractionDigits = "0" value="${p.price}" type="number"/> ₫</td>
							<td width="99px">${p.brand.name}</td>
							<td width="99px"><a href="admin/product/edit/${p.id}.htm">Chỉnh sửa</a></td>
							<td width="92px"><a href="admin/product/delete/${p.id}.htm">Xóa</a></td>
							<td width="102px"><a href="admin/product/${p.id}.htm">Xem trước</a></td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			
			<div style="margin-bottom: 10px; margin-top: 40px">
				<img src="./images/logo/suzuki.png"
					style="height: 30px; margin-left: 20px;"> <b>SUZUKI</b>
			</div>
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>Mã xe</th>
						<th>Tên xe</th>
						<th>Số lượng</th>
						<th>Giá tiền</th>
						<th>Hãng xe</th>
						<th>Thao tác</th>
						<th>Thao tác</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${products}">
						<c:if test="${p.brand.name == 'SUZUKI'}">
						<tr>
							<td>${p.id}</td>
							<td width="300px">${p.name}</td>
							<td width="99px">${p.amount}</td>
							<td width="140px"><f:formatNumber minFractionDigits = "0" value="${p.price}" type="number"/> ₫</td>
							<td width="99px">${p.brand.name}</td>
							<td width="99px"><a href="admin/product/edit/${p.id}.htm">Chỉnh sửa</a></td>
							<td width="92px"><a href="admin/product/delete/${p.id}.htm">Xóa</a></td>
							<td width="102px"><a href="admin/product/${p.id}.htm">Xem trước</a></td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table> --%>

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