<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ĐẶT HÀNG THÀNH CÔNG</title>
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
					<i class="fas fa-arrow-left"></i> Tiếp tục mua hàng
				</a>
			</p>
	</div>
	${message}
	<h3 style="text-align: center;">ĐẶT HÀNG THÀNH CÔNG</h3>
	<hr style="border-top: 2px solid red; margin-left: 100px; margin-right: 100px">
	<p style="margin-left: 110px; font-size: 20px;">
		Vui lòng kiểm tra chi tiết đơn hàng tại Email của bạn. Cảm ơn bạn đã tin tưởng mua hàng tại Showroom của chúng tôi !
	</p>
	
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