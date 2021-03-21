package ptithcm.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.bean.Mailer;
import ptithcm.entity.Advertisement;
import ptithcm.entity.Brand;
import ptithcm.entity.Order;
import ptithcm.entity.Product;
import ptithcm.entity.User;


@Transactional
@Controller
@RequestMapping("/home/")
public class HomeController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	Mailer mailer;
	
	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			model.addAttribute("isLogin", false);
		}
		if(user_session.getAttribute("user") != null) {
			model.addAttribute("isLogin", true);
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("ads", getAds());
		model.addAttribute("brands", getBrands());
		model.addAttribute("types", getTypes());
		return "home/index";
	}
	
	//lấy danh sách hãng
	@SuppressWarnings("unchecked")
	public List<Brand> getBrands() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Brand";
		Query query = session.createQuery(hql);
		List<Brand> list = query.list();
		return list;
	}
	
	//lấy loại xe
	public List<String> getTypes() {
		List<String> list = new ArrayList<>();
		list.add("Xe tay ga");
		list.add("Xe số");
		list.add("Xe côn tay");
		return list;
	}
	
	//lấy danh sách quảng cáo
	@SuppressWarnings("unchecked")
	public List<Advertisement> getAds() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Advertisement";
		Query query = session.createQuery(hql);
		List<Advertisement> list = query.list();
		return list;
	}
	
	//đăng nhập
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String adminlogin() {
		return "home/login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST) 
	public String adminlogin(HttpServletRequest request, ModelMap model) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		username.trim();
		password.trim();
		
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		for(User u : list) {
			if(username.equals(u.getUsername().trim())==true) {
				if(password.equals(u.getPassword().trim()) == false) {
					model.addAttribute("message2", "Sai mật khẩu !");
					return "home/login";
				}
				else {
					if(u.getRole() == true) {
						HttpSession admin_session = request.getSession();
						admin_session.setAttribute("admin", u);
						return "redirect:/admin/home.htm";
					}
					else {
						HttpSession user_session = request.getSession();
						user_session.setAttribute("user", u);
						return "redirect:/home/index.htm";
					}
				}
			}
		}
		model.addAttribute("message1", "Sai tên đăng nhập !");
		return "home/login";
	}
	
	//đăng xuất
	@RequestMapping("logout") 
	public String logout(ModelMap model, HttpServletRequest req) {
		HttpSession user_session = req.getSession();
		user_session.removeAttribute("user");
		return "redirect:/home/index.htm";
	}
	
	//xem sản phẩm
	@RequestMapping("{id}")
	public String show(ModelMap model, @PathVariable("id") String id, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			model.addAttribute("isLogin", false);
		}
		if(user_session.getAttribute("user") != null) {
			model.addAttribute("isLogin", true);
		}
		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);
		
		model.addAttribute("product", product);
		model.addAttribute("products", getProducts());
		model.addAttribute("brands", getBrands());
		return "home/show";
	}
	
	//lấy danh sách sản phẩm
	@SuppressWarnings("unchecked")
	public List<Product> getProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		return list;
	}
	
	//đăng ký tk mới
	@RequestMapping(value="register", method=RequestMethod.GET)
	public String register(ModelMap model) {
		model.addAttribute("user", new User());
		return "home/register";
	}
	
	@RequestMapping(value="register", method=RequestMethod.POST)
	public String register1(ModelMap model, @ModelAttribute("user") User user, 
										   HttpServletRequest request, BindingResult errors) {
		String repassword = request.getParameter("repassword").trim();
		
		if(user.getUsername().trim().length() == 0) {
			errors.rejectValue("username", "user", "Vui lòng nhập tên đăng nhập !");
		}
		if(user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "Vui lòng nhập mật khẩu !");
		}
		if(user.getLastname().trim().length() == 0) {
			errors.rejectValue("lastname", "user", "Vui lòng nhập họ !");
		}
		if(user.getFirstname().trim().length() == 0) {
			errors.rejectValue("firstname", "user", "Vui lòng nhập tên !");
		}
		if(user.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "user", "Vui lòng nhập email !");
		}
		if(user.getEmail().trim().length() != 0) {
			if(checkEmail(user.getEmail().trim()) == false) {
				errors.rejectValue("email", "user", "Email không hợp lệ. Vui lòng nhập lại email !");
				return "home/register";
			}
		}
		if(user.getPhone().trim().length() == 0) {
			errors.rejectValue("phone", "user", "Vui lòng nhập số điện thoại !");
		}
		if(user.getPhone().trim().length() != 0) {
			if(checkPhone(user.getPhone().trim()) == false) {
				errors.rejectValue("phone", "user", "Số điện thoại không hợp lệ !");
				return "home/register";
			}
		}
		if(user.getAddress().trim().length() == 0) {
			errors.rejectValue("address", "user", "Vui lòng nhập địa chỉ !");
		}
		if(errors.hasErrors()) {
			/*model.addAttribute("message", "Vui lòng kiểm tra lỗi !");*/
		}
		if(repassword.trim().length() == 0) {
			model.addAttribute("message_pass", "Vui lòng xác nhận mật khẩu !");
			return "home/register";
		}
		else {
			if(repassword.trim().equals(user.getPassword().trim()) == false) {
				model.addAttribute("message_pass", "Xác nhận mật khẩu không trùng khớp, vui lòng nhập lại !");
				return "home/register";
			}
			List<User> kiemtra = getUsers();
			for(User u : kiemtra) {
				if(user.getUsername().trim().equals(u.getUsername()) == true ) {
					errors.rejectValue("username", "user", "Tên đăng nhập đã tồn tại. Vui lòng nhập lại !");
					return "home/register";
				}
			}
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				user.setRole(false);
				session.save(user);
				t.commit();
				model.addAttribute("message", "Đăng ký thành công !");
				mailer.send("showroomxemay.nhatduy@gmail.com", user.getEmail(), 
						"ĐĂNG KÝ TÀI KHOẢN THÀNH CÔNG", 
						"Chúc mừng bạn đã đăng ký tài khoản thành công tại Showroom xe máy Nhật Duy. "
						+ "Showroom xe máy Nhật Duy xin cảm ơn !");
				return "redirect:/home/login.htm";
			}
			catch(Exception e) {
				t.rollback();
				model.addAttribute("message", "Đăng ký thất bại !");
			}
			finally {
				session.close();
			}
		}
		return "home/register";
	}
	
	// đổi mật khẩu
	@RequestMapping("changepass")
	public String changepass(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			return "redirect:/home/index.htm";
		}
		return "home/changepass";
	}
	
	@RequestMapping("change")
	public String change(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		User user = (User) user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			return "redirect:/home/index.htm";
		}
		String oldpass = req.getParameter("oldpass");
		String newpass = req.getParameter("newpass");
		String renewpass = req.getParameter("renewpass");
		oldpass.trim();
		newpass.trim();
		renewpass.trim();
		
		if(oldpass.length() == 0) {
			model.addAttribute("message", "Vui lòng điền đủ thông tin !");
			return "home/changepass";
		}
		if(newpass.length() == 0) {
			model.addAttribute("message", "Vui lòng điền đủ thông tin !");
			return "home/changepass";
		}
		if(renewpass.length() == 0) {
			model.addAttribute("message", "Vui lòng điền đủ thông tin !");
			return "home/changepass";
		}
		else {
			if(oldpass.equals(user.getPassword()) == false) {
				model.addAttribute("message", "Mật khẩu cũ không đúng !");
				return "home/changepass";
			}
			if(newpass.equals(renewpass) == false) {
				model.addAttribute("message", "Xác nhận mật khẩu mới không chính xác !");
				return "home/changepass";
			}
			else {
				Session session = factory.openSession();
				Transaction t = session.beginTransaction();
				try {
					user.setPassword(newpass);
					session.update(user);
					t.commit();
					model.addAttribute("message", "Đổi mật khẩu thành công !");
				}
				catch(Exception ex) {
					t.rollback();
					model.addAttribute("message", "Đổi mật khẩu thất bại !");
				}
				finally {
					session.close();
				}
			}
		}
		return "home/changepass";
	}
	
	//quên mật khẩu
	@RequestMapping(value="forgotpass", method=RequestMethod.GET)
	public String forgotpass(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		if(user_session.getAttribute("user") != null) {
			return "redirect:/home/index.htm";
		}
		else {
			return "home/forgotpass";
		}
	}
	
	@RequestMapping(value="forgotpass", method=RequestMethod.POST)
	public String forgotpass1(ModelMap model, HttpServletRequest req) {
		String uname = req.getParameter("uname");
		String mail = req.getParameter("mail");
		uname.trim();
		mail.trim();
		if(uname.length() == 0) {
			model.addAttribute("message", "Vui lòng điền đủ thông tin !");
			return "home/forgotpass";
		}
		if(mail.length() == 0) {
			model.addAttribute("message", "Vui lòng điền đủ thông tin !");
			return "home/forgotpass";
		}
		else {
			if(checkEmail(mail) == false) {
				model.addAttribute("message", "Email bạn nhập chưa đúng định dạng !");
				return "home/forgotpass";
			}
			List<User> check = getUsers();
			for(User u : check) {
				if(uname.trim().equals(u.getUsername())== true && mail.trim().equals(u.getEmail()) == true) {
					Session session = factory.openSession();
					Transaction t = session.beginTransaction();
					try {
						String newpass = randomNumber();
						model.addAttribute("message", "Mật khẩu của bạn đã được thay đổi. Vui lòng kiểm tra Email của bạn !");
						mailer.send("showroomxemay.nhatduy@gmail.com", mail, 
								"THÔNG BÁO TỪ SHOWROOM XE MÁY NHẬT DUY", 
								"Mật khẩu của bạn đã được đặt về mặc định là: " + newpass + " . Vui lòng đăng nhập lại để thay đổi mật khẩu mới. "
								+ "Showroom xe máy Nhật Duy xin cảm ơn !");
						u.setPassword(newpass);
						session.update(u);
						t.commit();
						return "home/forgotpass";
					}
					catch(Exception ex) {
						t.rollback();
						return "home/forgotpass";
					}
					finally {
						session.close();
					}
				}
			}
			model.addAttribute("message", "Username hoặc Email chưa đúng. Vui lòng kiểm tra lại !");
		}
		return "home/forgotpass";
	}
	
	// hàm kiểm tra email hợp lệ
	public Boolean checkEmail(String email) {
	        String emailPattern = "^[\\w!#$%&’*+/=?`{|}~^-]+(?:\\.[\\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";
	        Pattern regex = Pattern.compile(emailPattern);
	        Matcher matcher = regex.matcher(email);
	        if (matcher.find()) {
	            return true;
	        } else {
	            return false;
	        }
	}
	
	// hàm kiểm tra sđt
	public Boolean checkPhone(String phone) {
		String phonePattern = "[0]{1}[35789]{1}[0-9]{8}";
		Pattern regex = Pattern.compile(phonePattern);
		Matcher matcher = regex.matcher(phone);
		if(matcher.find()) {
			return true;
		}
		else {
			return false;
		}
	}
	
	//sinh số ngẫu nhiên
	public String randomNumber() {
		String randNumber = "";
		Random rd = new Random();
		for(int i = 0; i<8; i++) {
			Integer number = rd.nextInt(9);
			randNumber += number.toString();
		}
		return randNumber;
	}
	
	//lấy danh sách user
	@SuppressWarnings("unchecked")
	public List<User> getUsers() {
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}
	
	//mua hàng
	@RequestMapping(value="order/{id}", method=RequestMethod.GET)
	public String order(ModelMap model, @PathVariable("id") String id, HttpServletRequest req) {
		HttpSession user_session = req.getSession();
		user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			return "redirect:/home/index.htm";
		}
		Session session = factory.getCurrentSession();
		Product product = (Product) session.get(Product.class, id);
		
		model.addAttribute("product", product);
		model.addAttribute("products", getProducts());
		model.addAttribute("order", new Order());
		return "home/order";
	}
	
	@RequestMapping(value="order/{id}", method=RequestMethod.POST)
	public String order(ModelMap model, @ModelAttribute("order") Order order, BindingResult errors, 
									HttpServletRequest req, @PathVariable("id") String id) {
		HttpSession user_session = req.getSession();
		User user = (User) user_session.getAttribute("user");
		
		Session session1 = factory.getCurrentSession();
		Product product = (Product) session1.get(Product.class, id);
		
		model.addAttribute("product", product);
		model.addAttribute("products", getProducts());
		
		System.out.println(user.getUsername());
		System.out.println(product.getId());
		
		if(order.getDeliveryAddress().trim().length() == 0) {
			errors.rejectValue("deliveryAddress", "order", "Vui lòng nhập địa chỉ giao hàng !");
		}
		if(order.getNote().trim().length() == 0) {
			order.setNote("");
		}
		if(order.getAmount() == null) {
			errors.rejectValue("amount", "order", "Vui lòng nhập số lượng !");
		}
		if(errors.hasErrors()) {
			/*model.addAttribute("message", "Vui lòng kiểm tra lỗi !");
			System.out.println(errors);*/
		}
		else {
			Session session = factory.openSession();
			Session session2 = factory.openSession();
			Transaction t = session.beginTransaction();
			Transaction t2 = session2.beginTransaction();
			try {
				Integer newAmount = product.getAmount() - order.getAmount();
				product.setAmount(newAmount);
				session2.update(product);
				t2.commit();
			}
			catch(Exception ex) {
				t2.rollback();
			}
			try {
				Integer total = product.getPrice() * order.getAmount();
				order.setDate(new Date());
				order.setUser(user);
				order.setProduct(product);
				session.save(order);
				t.commit();
				model.addAttribute("message", "Đặt hàng thành công !");
				String body = "Chi tiết đơn hàng của bạn || " +
							  "Ngày: " + order.getDate() + " || " +
							  "Tên sản phẩm: " + product.getName() + " || " +
							  "Hãng sản xuất: " + product.getBrand().getName() + " || " +
							  "Giá tiền: " + product.getPrice() + " VNĐ " + " || " +
							  "Số lượng : " + order.getAmount() + " || " +
							  "Thành tiền : " + total + " VNĐ " + " || " +
							  "Tên khách hàng: " + user.getLastname() + " " + user.getFirstname() + " || " +
							  "Số điện thoại: " + user.getPhone() + " || " +
							  "Địa chỉ giao hàng: " + order.getDeliveryAddress() + " || " +
							  "Ghi chú: " + order.getNote() + " || ";
				mailer.send("showroomxemay.nhatduy@gmail.com", user.getEmail(), 
						"ĐẶT HÀNG THÀNH CÔNG TỪ SHOWROOM XE MÁY NHẬT DUY", 
						body + "Cảm ơn bạn đã đặt hàng tại website của chúng tôi. Vui lòng truy cập vào giỏ hàng của bạn để xem chi tiết đơn hàng của bạn. "
						+ "Showroom xe máy Nhật Duy xin cảm ơn !");
				return "redirect:/home/success.htm";	
			}
			catch(Exception e) {
				t2.rollback();
				t.rollback();
				model.addAttribute("message", "Đặt hàng thất bại !");
			}
			finally {
				session2.close();
				session.close();
			}
		}
		return "home/order";
	}
	
	@RequestMapping("success")
	public String success(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		if(user_session.getAttribute("user") == null) {
			return "redirect:/home/index.htm";
		}
		return "home/success";
	}
	
	//xem sản phẩm theo hãng
	@RequestMapping("finding/{id}")
	public String productsOfBrand(ModelMap model, @PathVariable("id") String id, 
											HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			model.addAttribute("isLogin", false);
		}
		if(user_session.getAttribute("user") != null) {
			model.addAttribute("isLogin", true);
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Product p WHERE p.brand.id = '" + id + "'";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("ads", getAds());
		model.addAttribute("brands", getBrands());
		model.addAttribute("types", getTypes());
		return "home/finding";
	}
	
	//tìm kiếm sản phẩm
	@RequestMapping("search")
	public String search(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			model.addAttribute("isLogin", false);
		}
		if(user_session.getAttribute("user") != null) {
			model.addAttribute("isLogin", true);
		}
		String keyword = req.getParameter("search");
		Session session = factory.getCurrentSession();
		String hql = "FROM Product p WHERE p.name LIKE '%" + keyword + "%'" ;
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("ads", getAds());
		model.addAttribute("brands", getBrands());
		return "home/search";
	}
	
	//Giỏ hàng của tôi
	@RequestMapping("mycart")
	public String mycart(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession user_session = req.getSession();
		user_session.getAttribute("user");
		if(user_session.getAttribute("user") == null) {
			return "redirect:/home/login.htm";
		}
		User user = (User) user_session.getAttribute("user");
		Session session = factory.getCurrentSession();
		String hql = "FROM Order o WHERE o.user.username = '" + user.getUsername() + "'";
		Query query = session.createQuery(hql);
		List<Order> list = query.list();
		model.addAttribute("orders", list);
		return "home/mycart";
	}
	
}
