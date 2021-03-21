<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>TÌM KIẾM THEO HÃNG</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<base href="${pageContext.servletContext.contextPath}/">
<style>
.duy1:HOVER {
	background-color: #9e1623;
}

.duy2:HOVER {
	color: white;
	background-color: green;
}
.img {
	width: 300px;
	height: 190px;
	margin-left: 58px;
}

.bottom {
	margin-bottom: 20px;
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
				style="color: white;"><i
					class="fas fa-motorcycle"></i><b> TRANG CHỦ</b></a>
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

	<div id="demo" class="carousel slide" data-ride="carousel">

		<!-- Indicators -->
		<ul class="carousel-indicators">
			<c:forEach var="a" items="${ads}" begin="0" varStatus="status">
				<c:choose>
					<c:when test="${status.index == 0}">
						<li data-target="#demo" data-slide-to="${status.index}" class="active"></li>
					</c:when>
					<c:when test="${status.index >0}">
						<li data-target="#demo" data-slide-to="${status.index}"></li>
					</c:when>
				</c:choose>
			</c:forEach>
		</ul>

		<!-- The slideshow -->
		<div class="carousel-inner">
			<c:forEach var="a" items="${ads}" begin="0" varStatus="status">
				<c:choose>
					<c:when test="${status.index == 0}">
						<div class="carousel-item active">
						<img src="./images/${a.image}"
							style="width: 100%; height: 550px">
					</div>
					</c:when>
					<c:when test="${status.index >0}">
						<div class="carousel-item">
						<img src="./images/${a.image}"
							style="width: 100%; height: 550px">
					</div>
					</c:when>
				</c:choose>
			</c:forEach>
		</div>

		<!-- Left and right controls -->
		<a class="carousel-control-prev" href="#demo" data-slide="prev"> <span
			class="carousel-control-prev-icon"></span>
		</a> <a class="carousel-control-next" href="#demo" data-slide="next">
			<span class="carousel-control-next-icon"></span>
		</a>
	</div>

	<div style="margin-top: 40px; margin-bottom: 20px">
		<h2 style="color: red; text-align: center;">
			<b>Kết quả tìm kiếm hãng ${products[0].brand.name}</b>
		</h2>
	</div>
	
	<c:forEach var="t" items="${types}">
		<div style="margin-bottom: 20px">
			<h3 style="margin-left: 90px; color: #007bff; margin-bottom: 10px; text-transform: uppercase;">${t}</h3>
			<div
				style="border-bottom: 2px solid #007bff; margin-left: 80px; margin-bottom: 10px; width: 87%">
			</div>
		</div>
		
		<div class="container-fluid" style="margin-bottom: 20px">
  			<div class="row">
  				<c:forEach var="p" items="${products}">
					<c:if test="${p.type == t}">
						<div class="col-4 bottom" title="${p.name}">
							<img class="img" src="./images/${p.image}">
							<p style="text-align: center; font-size: 17px">${p.name}</p>
							<p style="text-align: center; font-size: 17px">
								Giá:<b> <f:formatNumber minFractionDigits = "0" value="${p.price}" type="number"/> ₫</b>
							</p>
							<a href="home/${p.id}.htm" class="btn btn-danger" role="button" style="margin-left: 133px; width: 36.5%; border-radius: 20px;">
								Xem chi tiết ></a>
						</div>
					</c:if>
				</c:forEach>
  			</div>
		</div>
	</c:forEach>

	<!-- Footer -->
	<footer class="page-footer font-small">

		<div style="background-color: #343a40; color: white;">
			<div class="container">

				<!-- Grid row-->
				<div class="row py-4 d-flex align-items-center">

					<!-- Grid column -->
					<div class="col-md-6 col-lg-5 text-center text-md-left mb-4 mb-md-0">
						<h6 class="text-uppercase font-weight-bold">Thông tin liên hệ</h6>
						<hr style="border-top: 1px solid #007bff">
						<p>
							<i class="fas fa-home mr-3"></i> 1A Phan Đăng Lưu, Quận Phú Nhuận, TP. Hồ Chí Minh
						</p>
						<p>
							<i class="fas fa-envelope mr-3"></i> showroomxemay.nhatduy@gmail.com
						</p>
						<p>
							<i class="fas fa-phone mr-3"></i> (+84) 908 035 903
						</p>
					</div>
					<!-- Grid column -->
					
					<!-- Grid column -->
					<div class="col-md-6 col-lg-5 text-center text-md-left" style="margin-left: 180px;">
						<h6 class="text-uppercase font-weight-bold">Mạng xã hội</h6>
						<hr style="border-top: 1px solid #007bff">
						<!-- Facebook -->
						<a class="fb-ic"> <i class="fab fa-facebook-f white-text mr-4">
						</i>
						</a>
						<!-- Twitter -->
						<a class="tw-ic"> <i class="fab fa-twitter white-text mr-4">
						</i>
						</a>
						<!-- Google +-->
						<a class="gplus-ic"> <i
							class="fab fa-google-plus-g white-text mr-4"> </i>
						</a>
						<!--Linkedin -->
						<a class="li-ic"> <i
							class="fab fa-linkedin-in white-text mr-4"> </i>
						</a>
						<!--Instagram-->
						<a class="ins-ic"> <i class="fab fa-instagram white-text">
						</i>
						</a>
						<br>
						<br>
						<br>
						<br>
						<br>

					</div>
					<!-- Grid column -->

				</div>
				<!-- Grid row-->

			</div>
		</div>

		<!-- Copyright -->
		<div class="footer-copyright text-center py-3"
			style="background-color: #dc3545; color: white;">© 2019
			Copyright: DANG NHAT DUY</div>
		<!-- Copyright -->

	</footer>
	<!-- Footer -->

	<!-- 	thư viện    -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/66b27f5cfd.js"
		crossorigin="anonymous"></script>

	<!-- 	thư viện offline    -->
	<!-- 	<script src="../bootstrap/js/jquery-3.3.1.slim.min.js"></script> -->
	<!-- 	<script src="../bootstrap/js/popper.min.js"></script> -->
	<!-- 	<script src="../bootstrap/js/bootstrap.min.js"></script> -->
	<!-- 	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css"> -->
</body>
</html>