<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thêm sản phẩm mới</title>
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

.errors {
		color: red; font-style: italic;
}

@media screen and (max-height: 450px) {
	.sidebar {
		padding-top: 15px;
	}
	.sidebar a {
		font-size: 18px;
	}
}

input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
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
			<h3>Thêm sản phẩm mới</h3>
			<hr>
			${message}
			<form:form action="admin/product/insert.htm" method="post" modelAttribute="product" enctype="multipart/form-data">
				<div class="form-group">
					<label class="kc">Tên hãng</label>
					<br>
					<form:select class="form-control" style="width: 500px;" path="brand.id"
							items="${brands}" itemValue="id" itemLabel="name"/>
				</div>
				<div class="form-group">
					<label class="kc">Mã sản phẩm</label>
					<br>
					<form:input path="id" type="text" class="form-control" style="width: 500px;" autocomplete="off"/>
					<form:errors class="errors" path="id"/>
				</div>
				<div class="form-group">
					<label class="kc">Tên sản phẩm</label>
					<br>
					<form:input path="name" type="text" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="name"/>
				</div>
				<div class="form-group">
					<label class="kc">Loại xe</label>
					<br>
					<form:radiobutton path="type" style="margin-right: 5px" value="Xe tay ga" label="Xe tay ga"/>
					<form:radiobutton path="type" style="margin-right: 5px; margin-left: 10px;" value="Xe số" label="Xe số"/>
					<form:radiobutton path="type" style="margin-right: 5px; margin-left: 10px;" value="Xe côn tay" label="Xe côn tay"/>
					<p><form:errors class="errors" path="type"/></p>
				</div>
				<div class="form-group">
					<label class="kc">Giá tiền (vnd)</label>
					<br>
					<form:input path="price" type="number" min="0" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="price"/>
				</div>
				<div class="form-group">
					<label class="kc">Khối lượng (kg)</label>
					<br>
					<form:input path="weight" type="number" min="0" step="0.1" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="weight"/>
				</div>
				<div class="form-group">
					<label class="kc">Chiều dài (mm)</label>
					<br>
					<form:input path="length" type="number" min="0" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="length"/>
				</div>
				<div class="form-group">
					<label class="kc">Chiều rộng (mm)</label>
					<br>
					<form:input path="width" type="number" min="0" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="width"/>
				</div>
				<div class="form-group">
					<label class="kc">Chiều cao (mm)</label>
					<br>
					<form:input path="height" type="number" min="0" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="height"/>
				</div>
				<div class="form-group">
					<label class="kc">Dung tích động cơ (CC)</label>
					<br>
					<form:input path="enginecapacity" type="number" min="50" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="enginecapacity"/>
				</div>
				<div class="form-group">
					<label class="kc">Dung tích bình xăng (lít)</label>
					<br>
					<form:input path="tankcapacity" type="number" min="0" step="0.1" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="tankcapacity"/>
				</div>
				<div class="form-group">
					<label class="kc">Loại động cơ</label>
					<br>
					<form:input path="enginetype" type="text" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="enginetype"/>
				</div>
				<div class="form-group">
					<label class="kc">Số lượng</label>
					<br>
					<form:input path="amount" type="number" min="0" max="200" class="form-control" style="width: 500px;"/>
					<form:errors class="errors" path="amount"/>
				</div>
				<div class="form-group">
					<label class="kc">Hình ảnh</label>
					<br>
					<input type="file" name="photo">
					<p class="errors">${message_image}</p>
				</div>
				<button class="form-control" style="width: 500px; background-color: green; color: white">Thêm mới</button>
			</form:form>
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