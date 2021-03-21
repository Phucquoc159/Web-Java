<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ĐĂNG KÝ TÀI KHOẢN MỚI</title>
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
	font-size: 17px;
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
				<a href="home/login.htm" style="color: white;">
					<i class="fas fa-arrow-left"></i> Quay về đăng nhập
				</a>
			</p>
	</div>
	<div class="container ctn">
		<br>
		<h4 style="text-align: center;">Đăng ký tài khoản mới</h4>
		<hr>
		${message}
		<div class="container">
			<div class="admin">
				<form:form action="home/register.htm" method="post" modelAttribute="user">
						<div class="form-group">
							<label class="kc">Tên đăng nhập</label>
							<br>
							<form:input path="username" type="text" class="form-control" maxlength="20" autocomplete="off"/>
							<form:errors class="errors" path="username"/>
						</div>
						<div class="form-group">
							<label class="kc">Mật khẩu</label>
							<br>
							<form:input path="password" type="password" class="form-control" maxlength="15"/>
							<form:errors class="errors" path="password"/>
						</div>
						<div class="form-group">
							<label class="kc">Xác nhận mật khẩu</label>
							<br>
							<input name="repassword" type="password" class="form-control" maxlength="15"/>
							<p class="errors">${message_pass}</p>
						</div>
						<div class="form-group">
							<label class="kc">Họ</label>
							<br>
							<form:input path="lastname" type="text" class="form-control" maxlength="50"/>
							<form:errors class="errors" path="lastname"/>
						</div>
						<div class="form-group">
							<label class="kc">Tên</label>
							<br>
							<form:input path="firstname" type="text" class="form-control" maxlength="10"/>
							<form:errors class="errors" path="firstname"/>
						</div>
						<div class="form-group">
							<label class="kc">Địa chỉ email</label>
							<br>
							<form:input path="email" type="text" class="form-control"/>
							<form:errors class="errors" path="email"/>
						</div>
						<div class="form-group">
							<label class="kc">Số điện thoại</label>
							<br>
							<form:input path="phone" type="text" class="form-control"/>
							<form:errors class="errors" path="phone"/>
						</div>
						<div class="form-group">
							<label class="kc">Địa chỉ</label>
							<br>
							<form:input path="address" type="text" class="form-control" maxlength="200"/>
							<form:errors class="errors" path="address"/>
						</div>
						<button type="submit">Đăng ký</button>
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