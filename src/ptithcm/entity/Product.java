package ptithcm.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="Products")
public class Product {
	@Id
	@Column(name="Id")
	private String id;
	
	@Column(name="Name")
	private String name;
	
	@Column(name="Image")
	private String image;
	
	@Column(name="Type")
	private String type;
	
	@Column(name="Price")
	private Integer price;
	
	@Column(name="Weight")
	private Double weight;
	
	@Column(name="Length")
	private Integer length;
	
	@Column(name="Width")
	private Integer width;
	
	@Column(name="Height")
	private Integer height;
	
	@Column(name="EngineCapacity")
	private Integer enginecapacity;
	
	@Column(name="TankCapacity")
	private Double tankcapacity;
	
	@Column(name="EngineType")
	private String enginetype;
	
	@Column(name="Amount")
	private Integer amount;

	@ManyToOne
	@JoinColumn(name="brandId")
	private Brand brand;
	
	@OneToMany(mappedBy="product", fetch=FetchType.EAGER)
	private Collection<Order> orders;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Integer getEnginecapacity() {
		return enginecapacity;
	}

	public void setEnginecapacity(Integer enginecapacity) {
		this.enginecapacity = enginecapacity;
	}

	public Double getTankcapacity() {
		return tankcapacity;
	}

	public void setTankcapacity(Double tankcapacity) {
		this.tankcapacity = tankcapacity;
	}

	public String getEnginetype() {
		return enginetype;
	}

	public void setEnginetype(String enginetype) {
		this.enginetype = enginetype;
	}
	
	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Collection<Order> getOrders() {
		return orders;
	}

	public void setOrders(Collection<Order> orders) {
		this.orders = orders;
	}	
}
