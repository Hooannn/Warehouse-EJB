/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author nguyenduckhaihoan
 */
public class Product implements Serializable {
    private int id;
    
    private String sku;
    private String name;
    private String description;
    
    private Category category;
    
    private String brand;
    
    private BusinessPartner supplier;
    
    private ProductStatus status;
    
    private Date createdAt;
    
    public Product() {};

    public Product(int id, String sku, String name, String description, Category category, String brand, BusinessPartner supplier, ProductStatus status, Date createdAt) {
        this.id = id;
        this.sku = sku;
        this.name = name;
        this.description = description;
        this.category = category;
        this.brand = brand;
        this.supplier = supplier;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public BusinessPartner getSupplier() {
        return supplier;
    }

    public void setSupplier(BusinessPartner supplier) {
        this.supplier = supplier;
    }

    public ProductStatus getStatus() {
        return status;
    }

    public void setStatus(ProductStatus status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", sku=" + sku + ", name=" + name + ", description=" + description + ", category=" + category + ", brand=" + brand + ", supplier=" + supplier + ", status=" + status + ", createdAt=" + createdAt + '}';
    }
    
    
}
