<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ĐĂNG NHẬP</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../duy.css">
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

.ctn {
	width: 60%;
	margin-top: 10px;
	border: 3px solid #dc3545;
	border-radius: 20px;
	background-color: #e9ebee; 
}

input[type=text], input[type=password] {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	box-sizing: border-box;
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

.imgcontainer {
	text-align: center;
	margin: 20px 0 12px 0;
}

.admin {
	width: 50%;
	margin: auto;
}

.noti {
	color: red;
}

</style>

</head>
<body>
	<div style="background-color: #dc3545; width: 100%; height: 50px;">
			<p style="padding-top: 12px; padding-left: 24px; font-size: 17px;">
				<a href="home/index.htm" style="color: white;">
					<i class="fas fa-arrow-left"></i> Quay về trang chủ
				</a>
			</p>
	</div>
	<div class="container ctn">
		<form action="home/login.htm" method="post">
			<div class="imgcontainer">
				<img src="./images/img-01.png" alt="Avatar" class="avatar"
					style="width: 20%">
			</div>
	
			<div class="container" style="margin-bottom: 20px;"> 
				<div class="admin">
					<label for="uname" style="margin-bottom: 0px"><b>Tên đăng nhập</b></label> 
					<input type="text" placeholder="Username" name="username" required maxlength="20">
					<p class="noti">${message1}</p>
	
					<label for="psw" style="margin-bottom: 0px; margin-top: 5px"><b>Mật khẩu</b></label> 
					<input type="password" placeholder="Password" name="password" required maxlength="15">
					<p class="noti">${message2}</p>
					<p style="text-align: center;"><b><a href="home/forgotpass.htm">Quên mật khẩu ?</a></b></p>
					<button type="submit">Đăng nhập</button>
				</div>
			</div>
		</form>
		<p style="text-align: center;"><b>Bạn chưa có tài khoản? <a href="home/register.htm">Đăng ký ngay</a></b></p>
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