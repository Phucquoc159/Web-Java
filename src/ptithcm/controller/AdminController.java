package ptithcm.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.Advertisement;
import ptithcm.entity.Order;
import ptithcm.entity.User;

@Transactional
@Controller
@RequestMapping("/admin/")
public class AdminController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;

	@RequestMapping("home")
	public String home(HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		return "admin/home";
	}
	
	//đăng xuất
	@RequestMapping("logout")
	public String logout(HttpServletRequest req) {
		HttpSession logout_session = req.getSession();
		logout_session.removeAttribute("admin");
		return "redirect:/home/index.htm";
	}
	
	//index
	@RequestMapping("ad/index")
	public String ad_index(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Advertisement";
		Query query = session.createQuery(hql);
		List<Advertisement> list = query.list();
		model.addAttribute("ads", list);
		return "advertisement/index";
	}
	
	//insert
	@RequestMapping(value="ad/insert", method=RequestMethod.GET)
	public String insert(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		model.addAttribute("ad", new Advertisement());
		return "advertisement/insert";
	}
	
	@RequestMapping(value="ad/insert", method=RequestMethod.POST)
	public String insert(ModelMap model, @ModelAttribute("ad") Advertisement ad, 
										@RequestParam("photo") MultipartFile photo) {
		if(photo.isEmpty()) {
			model.addAttribute("message_image", "Vui lòng chọn hình ảnh !");
		}
		else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				String photoPath = context.getRealPath("./images/" + photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));
				ad.setImage(photo.getOriginalFilename());
				session.save(ad);
				t.commit();
				model.addAttribute("message", "Thêm mới thành công !");
				return "redirect:/admin/ad/index.htm";
			}
			catch(Exception e) {
				t.rollback();
				model.addAttribute("message", "Thêm mới thất bại !");
			}
			finally {
				session.close();
			}
		}
		return "advertisement/insert";
	}
	
	@SuppressWarnings("unchecked")
	public List<Advertisement> getAdvertisements() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Advertisement";
		Query query = session.createQuery(hql);
		List<Advertisement> list = query.list();
		return list;
	}
	
	//delete
	@RequestMapping(value="ad/delete/{id}")
	public String delete(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		System.out.println(id);
		Session session = factory.getCurrentSession();
		Advertisement ad = (Advertisement) session.get(Advertisement.class, id);
		
		model.addAttribute("ad", ad);
		model.addAttribute("ads", getAdvertisements());
		return "advertisement/delete";
	}
	
	@RequestMapping("ad/delete")
	public String delete(ModelMap model, @ModelAttribute("ad") Advertisement ad, HttpServletRequest req) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(ad);
			t.commit();
			model.addAttribute("message", "Xóa thành công !");
			return "redirect:/admin/ad/index.htm";
		}
		catch(Exception ex) {
			t.rollback();
			model.addAttribute("message", "Xóa thất bại !");
		}
		finally {
			session.close();
		}
		return "advertisement/delete";
	}
	
	@RequestMapping("orders")
	public String orders(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Order";
		Query query = session.createQuery(hql);
		List<Order> list = query.list();
		model.addAttribute("orders", list);
		return "admin/orders";
	}
	
	@RequestMapping("users") 
	public String users(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM User u WHERE u.role = false";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		model.addAttribute("users", list);
		return "admin/users";
	}
}
