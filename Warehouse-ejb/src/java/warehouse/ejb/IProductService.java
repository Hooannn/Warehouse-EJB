/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package warehouse.ejb;

import entity.*;
import java.util.List;
import javax.ejb.Remote;

/**
 *
 * @author nguyenduckhaihoan
 */
@Remote
public interface IProductService {
    public boolean add(Product entity);
    public boolean removeById(int id);
    public boolean update(Product entity);
    public Product getById(int id);
    public List<Product> getAll();    
    public List<Category> getAllCategories();
    public List<BusinessPartner> getAllSuppliers();
}

