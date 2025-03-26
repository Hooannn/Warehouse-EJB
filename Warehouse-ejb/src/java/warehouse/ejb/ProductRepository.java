/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package warehouse.ejb;

import entity.*;
import java.sql.*;

/**
 *
 * @author nguyenduckhaihoan
 */
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {

    private static final String URL = "jdbc:postgresql://localhost:5432/WarehouseManagementSystem";
    private static final String USER = "postgres";
    private static final String PASSWORD = "postgres";

    private static ProductRepository instance;
    private Connection connection;

    private ProductRepository() {
        try {
            Class.forName("org.postgresql.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connected to the database successfully!");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found!", e);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to connect to the database!", e);
        }
    }

    public static synchronized ProductRepository getInstance() {
        if (instance == null) {
            instance = new ProductRepository();
        }
        return instance;
    }

    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to re-establish the database connection!", e);
        }
        return connection;
    }

    public boolean addProduct(Product product) {
        boolean success = false;
        String sql = "insert into \"Product\" (\"ProductSKU\", \"Name\", \"Description\", \"CategoryID\", \"Brand\", \"SupplierID\") values (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setString(1, product.getSku());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getDescription());
            stmt.setInt(4, product.getCategory().getId());
            stmt.setString(5, product.getBrand());
            stmt.setInt(6, product.getSupplier().getId());
            stmt.executeUpdate();
            success = true;
        } catch (SQLException e) {
            success = false;
            System.err.println("Error adding product: " + e.getMessage());
        }
        return success;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = 
            "SELECT p.*, " +
            "       c.\"Name\" AS \"CategoryName\", c.\"CategoryID\" AS \"CategoryID\"," +
            "       bp.\"CompanyName\" AS \"SupplierName\", bp.\"PartnerID\" AS \"SupplierID\" " +
            "FROM \"Product\" p " +
            "JOIN \"Category\" c ON c.\"CategoryID\" = p.\"CategoryID\" " +
            "JOIN \"BusinessPartner\" bp ON p.\"SupplierID\" = bp.\"PartnerID\" ORDER BY p.\"ProductID\" ASC;";
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setSku(rs.getString("ProductSKU"));
                product.setDescription(rs.getString("Description"));
                product.setBrand(rs.getString("Brand"));
                product.setStatus(ProductStatus.valueOf(rs.getString("Status")));
                product.setCreatedAt(rs.getDate("CreatedAt"));
                
                Category category = new Category();
                category.setName(rs.getString("CategoryName"));
                category.setId(rs.getInt("CategoryID"));
                product.setCategory(category);
                
                BusinessPartner supplier = new BusinessPartner();
                supplier.setName(rs.getString("SupplierName"));
                supplier.setId(rs.getInt("SupplierID"));
                product.setSupplier(supplier);
                
                products.add(product);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving products: " + e.getMessage());
        }
        return products;
    }
    
    public Product getProductById(int productId) {
        Product product = null;
        String sql
                = "SELECT p.*, "
                + "       c.\"Name\" AS \"CategoryName\", c.\"CategoryID\" AS \"CategoryID\", "
                + "       bp.\"CompanyName\" AS \"SupplierName\", bp.\"PartnerID\" AS \"SupplierID\" "
                + "FROM \"Product\" p "
                + "JOIN \"Category\" c ON c.\"CategoryID\" = p.\"CategoryID\" "
                + "JOIN \"BusinessPartner\" bp ON p.\"SupplierID\" = bp.\"PartnerID\" "
                + "WHERE p.\"ProductID\" = ?;";
        try (PreparedStatement pstmt = getConnection().prepareStatement(sql)) {
            pstmt.setInt(1, productId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setId(rs.getInt("ProductID"));
                    product.setName(rs.getString("Name"));
                    product.setSku(rs.getString("ProductSKU"));
                    product.setDescription(rs.getString("Description"));
                    product.setBrand(rs.getString("Brand"));
                    product.setStatus(ProductStatus.valueOf(rs.getString("status")));
                    product.setCreatedAt(rs.getDate("CreatedAt"));

                    Category category = new Category();
                    category.setName(rs.getString("CategoryName"));
                    category.setId(rs.getInt("CategoryID"));
                    product.setCategory(category);

                    BusinessPartner supplier = new BusinessPartner();
                    supplier.setName(rs.getString("SupplierName"));
                    supplier.setId(rs.getInt("SupplierID"));
                    product.setSupplier(supplier);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving product by ID: " + e.getMessage());
        }
        return product;
    }
    
    
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "select * from \"Category\"";
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("CategoryID"));
                category.setName(rs.getString("Name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving categories: " + e.getMessage());
        }
        return categories;
    }
    
    public List<BusinessPartner> getAllSuppliers() {
        List<BusinessPartner> suppliers = new ArrayList<>();
        String sql = "select * from \"BusinessPartner\" bp where bp.\"IsSupplier\" = true";
        try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                BusinessPartner supplier = new BusinessPartner();
                supplier.setId(rs.getInt("PartnerID"));
                supplier.setName(rs.getString("CompanyName"));
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving suppliers: " + e.getMessage());
        }
        return suppliers;
    }

    public boolean updateProduct(Product product) {
        boolean success = false;
        String sql
                = "UPDATE \"Product\" "
                + "SET \"ProductSKU\" = ?, \"Name\" = ?, \"Description\" = ?, \"CategoryID\" = ?, \"Brand\" = ?, \"SupplierID\" = ?, \"status\" = ? "
                + "WHERE \"ProductID\" = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setString(1, product.getSku());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getDescription());
            stmt.setInt(4, product.getCategory().getId());
            stmt.setString(5, product.getBrand());
            stmt.setInt(6, product.getSupplier().getId());
            stmt.setObject(7, product.getStatus().toString(), java.sql.Types.OTHER);
            stmt.setInt(8, product.getId());
            stmt.executeUpdate();
            success = true;
        } catch (SQLException e) {
            success = false;
            System.err.println("Error updating product: " + e.getMessage());
        }
        return success;
    }

    public boolean deleteProduct(int id) {
        boolean success = false;
        String sql = "delete from \"Product\" p where p.\"ProductID\" = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            success = true;
        } catch (SQLException e) {
            success = false;
            System.err.println("Error deleting product: " + e.getMessage());
        }
        return success;
    }
}
