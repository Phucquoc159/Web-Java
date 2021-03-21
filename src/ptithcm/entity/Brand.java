package ptithcm.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import ptithcm.entity.Product;;

@Entity
@Table(name="Brands")
public class Brand {
	@Id
	@Column(name="Id")
	private String id;
	
	@Column(name="Name")
	private String name;
	
	@Column(name="Logo")
	private String logo;
	
	@OneToMany(mappedBy="brand", fetch=FetchType.EAGER)
	private Collection<Product> products;

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

	public Collection<Product> getProducts() {
		return products;
	}

	public void setProducts(Collection<Product> products) {
		this.products = products;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}
}
