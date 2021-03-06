package ptithcm.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.Brand;
import ptithcm.entity.Product;

@Transactional
@Controller
@RequestMapping("/admin/product/")
public class ProductController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	
	//index
	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		List<Product> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("brands", getBrands());
		return "product/index";
	}
	
	//insert
	@RequestMapping(value="insert", method=RequestMethod.GET)
	public String insert(ModelMap model, HttpServletRequest req, HttpServletResponse response) {
		HttpSession admin_session = req.getSession();
		admin_session.getAttribute("admin");
		if(admin_session.getAttribute("admin") == null) {
			return "redirect:/home/login.htm";
		}
		model.addAttribute("product", new Product());
		return "product/insert";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert(ModelMap model, @ModelAttribute("product") Product product, 
								@RequestParam("photo") MultipartFile photo, BindingResult errors) {
		if(photo.isEmpty()) {
			model.addAttribute("message_image", "Vui l??ng ch???n h??nh ???nh !");
		}
		if(product.getId().trim().length() == 0) {
			errors.rejectValue("id", "product", "Vui l??ng nh???p m?? s???n ph???m !");
		}
		if(product.getName().trim().length() == 0) {
			errors.rejectValue("name", "product", "Vui l??ng nh???p t??n s???n ph???m !");
		}
		if(product.getType() == null) {
			errors.rejectValue("type", "product", "Vui l??ng ch???n lo???i xe !");
		}
		if(product.getPrice() == null) {
			errors.rejectValue("price", "product", "Vui l??ng nh???p gi?? ti???n !");
		}
		if(product.getWeight() == null) {
			errors.rejectValue("weight", "product", "Vui l??ng nh???p kh???i l?????ng xe !");
		}
		if(product.getLength() == null) {
			errors.rejectValue("length", "product", "Vui l??ng nh???p chi???u d??i !");
		}
		if(product.getWidth() == null) {
			errors.rejectValue("width", "product", "Vui l??ng nh???p chi???u r???ng !");
		}
		if(product.getHeight() == null) {
			errors.rejectValue("height", "product", "Vui l??ng nh???p chi???u cao !");
		}
		if(product.getEnginecapacity() == null) {
			errors.rejectValue("enginecapacity", "product", "Vui l??ng nh???p dung t??ch ?????ng c?? !");
		}
		if(product.getTankcapacity() == null) {
			errors.rejectValue("tankcapacity", "product", "Vui l??ng nh???p dung t??ch b??nh x??ng !");
		}
		if(product.getEnginetype().trim().length() == 0) {
			errors.rejectValue("enginetype", "product", "Vui l??ng nh???p lo???i ?????ng c?? !");
		}
		if(product.getAmount() == null) {
			errors.rejectValue("amount", "product", "Vui l??ng nh???p s??? l?????ng !");
		}
		if(errors.hasErrors()) {
			/*model.addAttribute("message", "Vui l??ng ki???m tra l???i !");*/
		}
		else {
			List<Product> kiemtra = getProducts();
			for(Product check : kiemtra) {
				if(product.getId().trim().equals(check.getId().trim())) {
					errors.rejectValue("id", "product", "M?? s???n ph???m ???? t???n t???i!");
					return "product/insert";
				}
			}
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				String photoPath = context.getRealPath("./images/" + photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));
				product.setImage(photo.getOriginalFilename());
				session.save(product);
				t.commit();
				model.addAttribute("message", "Th??m m???i th??nh c??ng !");
				return "redirect:/admin/product/index.htm";
			}
			catch(Exception e) {
				t.rollback();
				model.addAttribute("message", "Th??m m???i th???t b???i !");
			}
			finally {
				session.close();
			}
		}
		return "product/insert";
	}
	
		//load danh s??ch h??ng xe ra combobox
		@ModelAttribute("brands")
		public List<Brand> getBrands() {
			Session session = factory.getCurrentSession();
			String hql = "FROM Brand";
			Query query = session.createQuery(hql);
			List<Brand> list = query.list();
			return list;
		}
		
		//update
		// l???y ds s???n ph???m
		@SuppressWarnings("unchecked")
		public List<Product> getProducts() {
			Session session = factory.getCurrentSession();
			String hql = "FROM Product";
			Query query = session.createQuery(hql);
			List<Product> list = query.list();
			return list;
		}
		
		@RequestMapping("edit/{id}")
		public String edit(ModelMap model, @PathVariable("id") String id, HttpServletRequest req, HttpServletResponse response) {
			HttpSession admin_session = req.getSession();
			admin_session.getAttribute("admin");
			if(admin_session.getAttribute("admin") == null) {
				return "redirect:/home/login.htm";
			}
			System.out.println(id);
			Session session = factory.getCurrentSession();
			Product product = (Product) session.get(Product.class, id);
			
			model.addAttribute("product", product);
			model.addAttribute("products", getProducts());
			return "product/update";
		}
		
		@RequestMapping("update")
		public String update(ModelMap model, @ModelAttribute("product") Product product,
				   							@RequestParam("photo") MultipartFile photo, BindingResult errors, HttpServletRequest req) {
			HttpSession admin_session = req.getSession();
			admin_session.getAttribute("admin");
			if(admin_session.getAttribute("admin") == null) {
				return "redirect:/home/login.htm";
			}
			if(photo.isEmpty()) {
				if(product.getName().trim().length() == 0) {
					errors.rejectValue("name", "product", "Vui l??ng nh???p t??n s???n ph???m !");
				}
				if(product.getType() == null) {
					errors.rejectValue("type", "product", "Vui l??ng ch???n lo???i xe !");
				}
				if(product.getPrice() == null) {
					errors.rejectValue("price", "product", "Vui l??ng nh???p gi?? ti???n !");
				}
				if(product.getWeight() == null) {
					errors.rejectValue("weight", "product", "Vui l??ng nh???p kh???i l?????ng xe !");
				}
				if(product.getLength() == null) {
					errors.rejectValue("length", "product", "Vui l??ng nh???p chi???u d??i !");
				}
				if(product.getWidth() == null) {
					errors.rejectValue("width", "product", "Vui l??ng nh???p chi???u r???ng !");
				}
				if(product.getHeight() == null) {
					errors.rejectValue("height", "product", "Vui l??ng nh???p chi???u cao !");
				}
				if(product.getEnginecapacity() == null) {
					errors.rejectValue("enginecapacity", "product", "Vui l??ng nh???p dung t??ch ?????ng c?? !");
				}
				if(product.getTankcapacity() == null) {
					errors.rejectValue("tankcapacity", "product", "Vui l??ng nh???p dung t??ch b??nh x??ng !");
				}
				if(product.getEnginetype().trim().length() == 0) {
					errors.rejectValue("enginetype", "product", "Vui l??ng nh???p lo???i ?????ng c?? !");
				}
				if(product.getAmount() == null) {
					errors.rejectValue("amount", "product", "Vui l??ng nh???p s??? l?????ng !");
				}
				if(errors.hasErrors()) {
					/*model.addAttribute("message", "Vui l??ng ki???m tra l???i !");*/
				}
				else {
					String oldImage = product.getImage();
					Session session = factory.openSession();
					Transaction t = session.beginTransaction();
					try {
						product.setImage(oldImage);
						session.update(product);
						t.commit();
						model.addAttribute("message", "C???p nh???t th??nh c??ng !");
						return "redirect:/admin/product/index.htm";
					}
					catch(Exception e) {
						t.rollback();
						model.addAttribute("message", "C???p nh???t th???t b???i !");
					}
					finally {
						session.close();
					}
				}
				return "product/update";
			}
			else {
				if(product.getName().trim().length() == 0) {
					errors.rejectValue("name", "product", "Vui l??ng nh???p t??n s???n ph???m !");
				}
				if(product.getType() == null) {
					errors.rejectValue("type", "product", "Vui l??ng ch???n lo???i xe !");
				}
				if(product.getPrice() == null) {
					errors.rejectValue("price", "product", "Vui l??ng nh???p gi?? ti???n !");
				}
				if(product.getWeight() == null) {
					errors.rejectValue("weight", "product", "Vui l??ng nh???p kh???i l?????ng xe !");
				}
				if(product.getLength() == null) {
					errors.rejectValue("length", "product", "Vui l??ng nh???p chi???u d??i !");
				}
				if(product.getWidth() == null) {
					errors.rejectValue("width", "product", "Vui l??ng nh???p chi???u r???ng !");
				}
				if(product.getHeight() == null) {
					errors.rejectValue("height", "product", "Vui l??ng nh???p chi???u cao !");
				}
				if(product.getEnginecapacity() == null) {
					errors.rejectValue("enginecapacity", "product", "Vui l??ng nh???p dung t??ch ?????ng c?? !");
				}
				if(product.getTankcapacity() == null) {
					errors.rejectValue("tankcapacity", "product", "Vui l??ng nh???p dung t??ch b??nh x??ng !");
				}
				if(product.getEnginetype().trim().length() == 0) {
					errors.rejectValue("enginetype", "product", "Vui l??ng nh???p lo???i ?????ng c?? !");
				}
				if(product.getAmount() == null) {
					errors.rejectValue("amount", "product", "Vui l??ng nh???p s??? l?????ng !");
				}
				if(errors.hasErrors()) {
					/*model.addAttribute("message", "Vui l??ng ki???m tra l???i !");*/
				}
				else {
					Session session = factory.openSession();
					Transaction t = session.beginTransaction();
					try {
						String photoPath = context.getRealPath("./images/" + photo.getOriginalFilename());
						photo.transferTo(new File(photoPath));
						product.setImage(photo.getOriginalFilename());
						session.update(product);
						t.commit();
						model.addAttribute("message", "C???p nh???t th??nh c??ng !");
						return "redirect:/admin/product/index.htm";
					}
					catch(Exception e) {
						t.rollback();
						model.addAttribute("message", "C???p nh???t th???t b???i !");
					}
					finally {
						session.close();
					}
				}
			}
			return "product/update";
		}
		
		//delete
		@RequestMapping("delete/{id}")
		public String delete(ModelMap model, @PathVariable("id") String id, HttpServletRequest req, HttpServletResponse response) {
			HttpSession admin_session = req.getSession();
			admin_session.getAttribute("admin");
			if(admin_session.getAttribute("admin") == null) {
				return "redirect:/home/login.htm";
			}
			System.out.println(id);
			Session session = factory.getCurrentSession();
			Product product = (Product) session.get(Product.class, id);
			
			model.addAttribute("product", product);
			model.addAttribute("products", getProducts());
			return "product/delete";
		}
		
		@RequestMapping("delete")
		public String delete(ModelMap model, @ModelAttribute("product") Product product, HttpServletRequest req) {
			HttpSession admin_session = req.getSession();
			admin_session.getAttribute("admin");
			if(admin_session.getAttribute("admin") == null) {
				return "redirect:/home/login.htm";
			}
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.delete(product);
				t.commit();
				model.addAttribute("message", "X??a th??nh c??ng !");
				return "redirect:/admin/product/index.htm";
			}
			catch(Exception e) {
				t.rollback();
				model.addAttribute("message", "X??a th???t b???i !");
			}
			finally {
				session.close();
			}
			return "product/delete";
		}
		
		//hi???n th??? th??ng tin s???n ph???m
		@RequestMapping("{id}")
		public String show(ModelMap model, @PathVariable("id") String id, HttpServletRequest req, HttpServletResponse response) {
			HttpSession admin_session = req.getSession();
			admin_session.getAttribute("admin");
			if(admin_session.getAttribute("admin") == null) {
				return "redirect:/home/login.htm";
			}
			System.out.println(id);
			Session session = factory.getCurrentSession();
			Product product = (Product) session.get(Product.class, id);
			
			model.addAttribute("product", product);
			model.addAttribute("products", getProducts());
			return "product/show";
		}
}
