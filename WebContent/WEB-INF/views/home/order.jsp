<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MUA HÀNG</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../duy.css">
<style>
.ctn {
	width: 70%;
	margin-top: 10px;
	border: 3px solid #dc3545;
	border-radius: 20px;
	background-color: #e9ebee; 
}

button {
	background-color: green;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	cursor: pointer;
	width: 100%;
	border-radius: 10px; 
}

button:hover {
	opacity: 0.8;
}

.kc {
	font-size: 18px;
	margin-bottom: 3px;
	margin-left: 4px;
}

.errors {
	color: red; font-style: italic;
}

.admin {
	width: 50%;
	margin: auto;
}
</style>
</head>
<body>
	<div style="background-color: #dc3545; width: 100%; height: 50px;">
			<p style="padding-top: 12px; padding-left: 24px; font-size: 17px;">
				<a href="home/${product.id}.htm" style="color: white;">
					<i class="fas fa-arrow-left"></i> Quay về trang sản phẩm
				</a>
			</p>
	</div>
	<div class="container ctn">
		<br>
		<h3 style="text-align: center;">Xác nhận mua hàng</h3>
		<hr>
		${message}
		<div class="container">
			<div class="admin">
				<form:form action="home/order/${product.id}.htm" method="post" modelAttribute="order">
						<div class="form-group">
							<label class="kc"><b>Họ tên khách hàng:</b> ${sessionScope.user.getLastname()} ${sessionScope.user.getFirstname()}</label>
							<br>
						</div> 
						<div class="form-group">
							<label class="kc"><b>Số điện thoại:</b> ${sessionScope.user.getPhone()}</label>
							<br>
						</div>
						<div class="form-group">
							<label class="kc"><b>Email:</b> ${sessionScope.user.getEmail()}</label>
							<br>
						</div>
						<div class="form-group">
							<label class="kc"><b>Tên sản phẩm:</b> ${product.name}</label>
							<br>
						</div>
						<div class="form-group">
							<label class="kc"><b>Loại xe:</b> ${product.type}</label>
							<br>
						</div>
						<div class="form-group">
							<label class="kc"><b>Hãng sản xuất:</b> ${product.brand.name}</label>
							<br>
						</div>
						<div class="form-group">
							<label class="kc"><b>Giá tiền :</b> <f:formatNumber minFractionDigits = "0" value="${product.price}" type="number"/> ₫</label>
							<br>
						</div>
						<div class="form-group">
							<label class="kc"><b>Số lượng</b></label>
							<br>
							<form:input path="amount" type="number" min="1" max="5" class="form-control"/>
							<form:errors class="errors" path="amount" />
						</div>
						<div class="form-group">
							<label class="kc"><b>Địa chỉ giao hàng</b></label>
							<br>
							<form:input path="deliveryAddress" type="text" class="form-control"/>
							<form:errors class="errors" path="deliveryAddress" />
						</div>
						<div class="form-group">
							<label class="kc"><b>*Ghi chú (Nếu có thay đổi gì về thông tin liên hệ hoặc số điện thoại vui lòng ghi chú bên dưới)</b></label>
							<br>
							<form:textarea path="note" class="form-control" rows="5" />
						</div>
						<button type="submit">Mua hàng</button>
					</form:form>
				</div>
			</div>
			<hr>
	</div>
	<br>
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