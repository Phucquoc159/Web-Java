<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Xóa sản phẩm</title>
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

.kc {
	font-size: 18px;
	margin-bottom: 3px;
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
			<h3>Bạn chắc chắn muốn xóa ? Vui lòng kiểm tra lại trước khi xóa !</h3>
			<hr>
			${message}
			<form:form action="admin/product/delete.htm" modelAttribute="product">
				<div class="form-group">
					<label class="kc">Tên hãng</label>
					<br>
					<form:select class="form-control" style="width: 500px;" path="brand.id"
							items="${brands}" itemValue="id" itemLabel="name"/>
				</div>
				<div class="form-group">
					<label class="kc">Mã sản phẩm</label>
					<br>
					<form:input readonly="true" path="id" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Tên sản phẩm</label>
					<br>
					<form:input readonly="true" path="name" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Loại xe</label>
					<br>
					<form:radiobutton path="type" style="margin-right: 5px;" value="Xe tay ga" label="Xe tay ga"/>
					<form:radiobutton path="type" style="margin-right: 5px; margin-left: 10px;" value="Xe số" label="Xe số"/>
					<form:radiobutton path="type" style="margin-right: 5px; margin-left: 10px;" value="Xe côn tay" label="Xe côn tay"/>
				</div>
				<div class="form-group">
					<label class="kc">Giá tiền</label>
					<br>
					<form:input readonly="true" path="price" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Khối lượng</label>
					<br>
					<form:input readonly="true" path="weight" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Chiều dài</label>
					<br>
					<form:input readonly="true" path="length" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Chiều rộng</label>
					<br>
					<form:input readonly="true" path="width" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Chiều cao</label>
					<br>
					<form:input readonly="true" path="height" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Dung tích động cơ</label>
					<br>
					<form:input readonly="true" path="enginecapacity" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Dung tích bình xăng</label>
					<br>
					<form:input readonly="true" path="tankcapacity" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Loại động cơ</label>
					<br>
					<form:input readonly="true" path="enginetype" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Số lượng</label>
					<br>
					<form:input readonly="true" path="amount" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<div class="form-group">
					<label class="kc">Hình ảnh</label>
					<br>
					<form:input readonly="true" path="image" type="text" class="form-control" style="width: 500px;"/>
				</div>
				<button class="form-control" style="width: 500px; background-color: red; color: white">Xóa</button>
			</form:form>
			<br>
			<a href="admin/product/index.htm" class="btn btn-info btn-sm" role="button" style="width: 500px;">Hủy</a>
			<hr>
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