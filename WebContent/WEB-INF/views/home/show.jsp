<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thông tin sản phẩm</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../duy.css">
<base href="${pageContext.servletContext.contextPath}/">
<style>
.img {
	margin-top: 10px;
	margin-left: 80px;
	width: 520px;
	height: 320px;
}

.click:HOVER {
	background-color:#dc3545!important; 
}
</style>
</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<nav class="navbar navbar-expand-sm bg-danger navbar-danger">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link duy1" href="home/index.htm"
																style="color: white;">
				<i class="fas fa-motorcycle"></i><b> TRANG CHỦ</b></a>
			</li>
			<li class="nav-item dropdown">
			<a
				class="nav-link dropdown-toggle duy1" href="#" id="navbardrop"
				data-toggle="dropdown" style="color: white; margin-left: 20px">
					<b>SẢN PHẨM</b>
			</a>
				<div class="dropdown-menu">
					<c:forEach var="b" items="${brands}">
						<a class="dropdown-item duy2" href="home/finding/${b.id}.htm"><img
							src="./images/logo/${b.logo}" style="height: 25px; width: 50px">
							<b>${b.name}</b>
						</a>
						<hr>
					</c:forEach>
				</div>
			</li>
			<li class="nav-item" style="margin-left: 10px">
				<!-- 	Thanh tìm kiếm  -->
				<form class="form-inline" action="home/search.htm">
					<input class="form-control mr-sm-2" name="search"
								style="width: 350px" type="text" placeholder="Tìm kiếm sản phẩm...">
					<button class="btn btn-success" type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
				</form>
			</li>
		</ul>

		<c:if test="${isLogin == false}">
			<ul class="navbar-nav" style="margin-left: 300px">
				<li class="nav-item"><a class="nav-link duy1" href="home/login.htm" 
															style="color: white; margin-right: 5px">		
					<i class="far fa-user"></i> Đăng nhập</a> 
				</li>
						
				<!-- Dropdown -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle duy1" href="#" id="navbardrop"
					data-toggle="dropdown" style="color: white"><i
						class="fas fa-globe"></i> Ngôn ngữ </a>
					<div class="dropdown-menu">
						<a class="dropdown-item duy2" href="#"><img
							src="./images/logo/vietnam.png" style="height: 20px;"> Tiếng
							Việt</a> <a class="dropdown-item duy2" href="#"><img
							src="./images/logo/uk.jpg" style="height: 15px;"> English</a>
					</div></li>
			</ul>
		</c:if>
		
		<c:if test="${isLogin == true}">
			<ul class="navbar-nav" style="margin-left: 245px">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle duy1" href="#" id="navbardrop"
					data-toggle="dropdown" style="color: white"><i
						class="far fa-user"></i> ${sessionScope.user.getLastname()} ${sessionScope.user.getFirstname()} </a>
					<div class="dropdown-menu" style="font-size: 18px;">
						<a class="dropdown-item duy2" href="#" data-toggle="modal" data-target="#myModal"> Thông tin của tôi</a>
						<hr>
						<a class="dropdown-item duy2" href="home/mycart.htm" ><i class="fas fa-shopping-cart"></i> Đơn hàng của tôi</a> 
						<hr>
						<a class="dropdown-item duy2" href="home/logout.htm" ><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
					</div>
				</li>
						
				<!-- Dropdown -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle duy1" href="#" id="navbardrop"
					data-toggle="dropdown" style="color: white"><i
						class="fas fa-globe"></i> Ngôn ngữ </a>
					<div class="dropdown-menu">
						<a class="dropdown-item duy2" href="#"><img
							src="./images/logo/vietnam.png" style="height: 20px;"> Tiếng
							Việt</a> 
						<a class="dropdown-item duy2" href="#"><img
							src="./images/logo/uk.jpg" style="height: 15px;"> English</a>
					</div>
				</li>
			</ul>
		</c:if>
	</nav>
	
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header" style="background-color: #dc3545; color: white;">
					<h4 class="modal-title">Thông tin cá nhân</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body" style="font-size: 20px;">Họ tên: ${sessionScope.user.getLastname()} ${sessionScope.user.getFirstname()}</div>
				<div class="modal-body" style="font-size: 20px;">Số điện thoại: ${sessionScope.user.getPhone()}</div>
				<div class="modal-body" style="font-size: 20px;">Email: ${sessionScope.user.getEmail()}</div>
				<div class="modal-body" style="font-size: 20px;">Địa chỉ: ${sessionScope.user.getAddress()}</div>
				<div class="modal-body" style="font-size: 20px;"><a href="home/changepass.htm">Thay đổi mật khẩu</a></div>
				

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Đóng</button>
				</div>

			</div>
		</div>
	</div>
	
	<div style="background-color: #efefef; width: 100%; height: 50px;">
		<p style="padding-top: 12px; padding-left: 24px; font-size: 17px; text-transform: uppercase;">
			<a href="home/index.htm" style="color: black;">Trang chủ</a> > 
			${product.type} - ${product.brand.name} > 
			<a href="home/${product.id}.htm" style="color: black;">${product.name}</a>
		</p>
	</div>
	
	<div class="container-fluid">
  		<div class="row">
    		<div class="col-6" style="border-right: 2px solid #f7f7f7; border-bottom: 2px solid #f7f7f7;">
      			<img src="./images/${product.image}" class="img">
    		</div>
    		<div class="col-6">
      			<p style="padding-top: 10px; padding-left: 10px; font-size: 24px;">
      				Tên sản phẩm : ${product.name}
      			</p>
      			<hr style="border-top: 2px solid #f7f7f7; margin-left:8px; width: 100%">
      			<div style="margin-left: 10px;">
      				<div class="row">
  						<div class="col-sm-4"><b>SKU: ${product.id}</b></div>
  						<div class="col-sm-4"><b>Loại: ${product.type}</b></div>
  						<div class="col-sm-4"><b>Thương hiệu: ${product.brand.name}</b></div>
					</div>
				</div>
      			<hr style="border-top: 2px solid #dc3545; margin-left: 8px; width: 100%">	
      			<div style="margin-left: 10px;">
      				<h4 style="color: red;">
      						<f:formatNumber minFractionDigits = "0" value="${product.price}" type="number"/> ₫</h4>
      				<br>
      				<ul>
      					<li style="font-size: 14px;">
      						Mỗi lần bạn chỉ được đặt hàng 1 sản phẩm
      					</li>
      					<li style="font-size: 14px;">
      						Giá bán xe đã bao gồm thuế VAT, không bao gồm thuế trước bạ và chi phí làm giấy tờ, biển số
      					</li>
      					<li style="font-size: 14px;">
      						Thông tin bảo hành: 3 năm / 30.000 km (Tùy điều kiện nào đến trước)
      					</li>
      					<li style="font-size: 14px;">
      						Đối với đơn hàng thanh toán trả sau (COD), sau 5 ngày nếu khách hàng không đến nhận xe và thanh toán tại Showroom thì Đơn hàng sẽ tự động hủy
      					</li>
      				</ul>
      			</div>
      			<hr style="border-top: 2px solid #f7f7f7; margin-left:8px; width: 100%">
      			
      			<c:if test="${product.amount == 0}">
					<a href="#" class="btn disabled" role="button" 
										style="background-color: red; color: white; width: 220px; margin-left: 180px;">
	      				<b><i class="fas fa-shopping-cart"></i> MUA HÀNG</b>
	      			</a>
	      			<p style="margin-left: 184px; padding-top: 10px; color: blue;">
	      				<i>* Sản phẩm tạm thời hết hàng</i>
	      			</p>
      			</c:if>
      			
      			<c:if test="${product.amount > 0}">
      				<c:choose>
      					<c:when test="${isLogin == false}">
      						<a href="#" class="btn disabled" role="button" 
										style="background-color: red; color: white; width: 220px; margin-left: 180px;">
	      						<b><i class="fas fa-shopping-cart"></i> MUA HÀNG</b>
	      					</a>
	      					<p style="margin-left: 148px; padding-top: 10px; color: blue;">
	      						<i>* Vui lòng đăng nhập để tiếp tục mua hàng</i>
	      					</p>
      					</c:when>
      					<c:when test="${isLogin == true}">
      						<a href="home/order/${product.id}.htm" class="btn click" role="button" 
										style="background-color: red; color: white; width: 220px; margin-left: 180px;">
	      						<b><i class="fas fa-shopping-cart"></i> MUA HÀNG</b>
	      					</a>
      					</c:when>
      				</c:choose>
      			</c:if>
      			
    		</div>
  		</div>
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