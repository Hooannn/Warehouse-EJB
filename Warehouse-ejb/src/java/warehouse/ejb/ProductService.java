/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package warehouse.ejb;

import entity.*;
import javax.ejb.Stateless;
import java.util.List;

/**
 *
 * @author nguyenduckhaihoan
 */
@Stateless
public class ProductService implements IProductService {

    ProductRepository productRepository = ProductRepository.getInstance();

    @Override
    public boolean add(Product product) {
        return productRepository.addProduct(product);
    }

    @Override
    public boolean update(Product product) {
        return productRepository.updateProduct(product);
    }

    @Override
    public List<Product> getAll() {
        return productRepository.getAllProducts();
    }

    @Override
    public boolean removeById(int id) {
        return productRepository.deleteProduct(id);
    }

    @Override
    public Product getById(int id) {
        return productRepository.getProductById(id);
    }

    @Override
    public List<Category> getAllCategories() {
        return productRepository.getAllCategories();
    }

    @Override
    public List<BusinessPartner> getAllSuppliers() {
        return productRepository.getAllSuppliers();
    }
}
