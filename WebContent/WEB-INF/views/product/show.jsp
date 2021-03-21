<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thông tin sản phẩm</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../duy.css">
<style>
.img {
	height: 300px;
	width: 500px;
	margin-bottom: 10px;
	margin-left: 310px;
}
</style>
</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<div class="container">
		<img src="./images/${product.image}" class="img">
		<h4 style="text-align: center;">Tên sản phẩm: ${product.name}</h4>
		<h4 style="text-align: center;">Giá tiền: <f:formatNumber minFractionDigits = "0" value="${product.price}" type="number"/> ₫</h4>
	</div>

	<div style="margin-top: 40px; margin-bottom: 20px">
		<h2 style="color: red; text-align: center;">
			<b>THÔNG SỐ KỸ THUẬT</b>
		</h2>
	</div>
	
	<div class="container">
		<table class="table table-striped">
			<tbody>
				<tr>
					<td><b>Hãng sản xuất</b></td>
					<td>${product.brand.name}</td>
				</tr>
				<tr>
					<td><b>Khối lượng bản thân</b></td>
					<td>${product.weight} kg</td>
				</tr>
				<tr>
					<td><b>Dài x Rộng x Cao</b></td>
					<td>${product.length} x ${product.width} x ${product.height} mm</td>
				</tr>
				<tr>
					<td><b>Dung tích bình xăng</b></td>
					<td>${product.tankcapacity} lít</td>
				</tr>
				<tr>
					<td><b>Thể tích xy-lanh</b></td>
					<td>${product.enginecapacity} CC</td>
				</tr>
				<tr>
					<td><b>Loại động cơ</b></td>
					<td>${product.enginetype}</td>
				</tr>
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