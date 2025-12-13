package entity;

import core.DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Enhanced Data Access Object for Product entity with color and size
 * @author Student
 */
public class ProductDAO implements DAO<Product> {

    public ProductDAO() {
    }

    /**
     * Get a single product by ID
     * @param id
     * @return
     */
    @Override
    public Optional<Product> get(int id) {
        DB db = DB.getInstance();
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM HD_Product_Catalog WHERE Product_ID = ?";
            PreparedStatement stmt = db.getPreparedStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            Product product = null;
            while (rs.next()) {
                product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_Name"),
                        rs.getString("Description"),
                        rs.getString("Color"),
                        rs.getString("Size"),
                        rs.getDouble("Price"),
                        rs.getString("Image_URL")
                );
            }
            return Optional.ofNullable(product);
        } catch (SQLException ex) {
            System.err.println(ex.toString());
            return Optional.empty();
        } catch (Exception ex) {
            System.err.println(ex.toString());
            return Optional.empty();
        }
    }

    /**
     * Get all products
     * @return
     */
    @Override
    public List<Product> getAll() {
        DB db = DB.getInstance();
        ResultSet rs = null;
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM HD_Product_Catalog ORDER BY Product_ID";
            rs = db.executeQuery(sql);
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_Name"),
                        rs.getString("Description"),
                        rs.getString("Color"),
                        rs.getString("Size"),
                        rs.getDouble("Price"),
                        rs.getString("Image_URL")
                );
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            System.err.println(ex.toString());
            return null;
        }
    }

    /**
     * Get next available product ID
     * @return next ID
     */
    public int getNextId() {
        DB db = DB.getInstance();
        ResultSet rs = null;
        try {
            String sql = "SELECT MAX(Product_ID) as max_id FROM HD_Product_Catalog";
            rs = db.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("max_id") + 1;
            }
            return 1;
        } catch (SQLException ex) {
            System.err.println(ex.toString());
            return 1;
        }
    }

    /**
     * Insert a new product
     * @param product
     */
    @Override
    public void insert(Product product) {
        DB db = DB.getInstance();
        try {
            // If product ID is 0, get next available ID
            if (product.getProductID() == 0) {
                product.setProductID(getNextId());
            }

            String sql = "INSERT INTO HD_Product_Catalog(Product_ID, Product_Name, Description, Color, Size, Price, Image_URL) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = db.getPreparedStatement(sql);
            stmt.setInt(1, product.getProductID());
            stmt.setString(2, product.getProductName());
            stmt.setString(3, product.getDescription());
            stmt.setString(4, product.getColor());
            stmt.setString(5, product.getSize());
            stmt.setDouble(6, product.getPrice());
            stmt.setString(7, product.getImageUrl());
            int rowInserted = stmt.executeUpdate();
            if (rowInserted > 0) {
                System.out.println("A new product was inserted successfully!");
            }
        } catch (SQLException ex) {
            System.err.println(ex.toString());
        }
    }

    /**
     * Update an existing product
     * @param product
     */
    @Override
    public void update(Product product) {
        DB db = DB.getInstance();
        try {
            String sql = "UPDATE HD_Product_Catalog SET Product_Name=?, Description=?, Color=?, Size=?, Price=?, Image_URL=? WHERE Product_ID=?";
            PreparedStatement stmt = db.getPreparedStatement(sql);
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getDescription());
            stmt.setString(3, product.getColor());
            stmt.setString(4, product.getSize());
            stmt.setDouble(5, product.getPrice());
            stmt.setString(6, product.getImageUrl());
            stmt.setInt(7, product.getProductID());
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("An existing product was updated successfully!");
            }
        } catch (SQLException ex) {
            System.err.println(ex.toString());
        }
    }

    /**
     * Delete a product
     * @param product
     */
    @Override
    public void delete(Product product) {
        DB db = DB.getInstance();
        try {
            String sql = "DELETE FROM HD_Product_Catalog WHERE Product_ID = ?";
            PreparedStatement stmt = db.getPreparedStatement(sql);
            stmt.setInt(1, product.getProductID());
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("A product was deleted successfully!");
            }
        } catch (SQLException ex) {
            System.err.println(ex.toString());
        }
    }

    /**
     * Delete a product by ID
     * @param id
     */
    public void deleteById(int id) {
        DB db = DB.getInstance();
        try {
            String sql = "DELETE FROM HD_Product_Catalog WHERE Product_ID = ?";
            PreparedStatement stmt = db.getPreparedStatement(sql);
            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Product with ID " + id + " was deleted successfully!");
            }
        } catch (SQLException ex) {
            System.err.println(ex.toString());
        }
    }

    /**
     * Get column names
     * @return
     */
    @Override
    public List<String> getColumnNames() {
        DB db = DB.getInstance();
        ResultSet rs = null;
        List<String> headers = new ArrayList<>();
        try {
            String sql = "SELECT * FROM HD_Product_Catalog WHERE Product_ID = -1";
            rs = db.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int numberCols = rsmd.getColumnCount();
            for (int i = 1; i <= numberCols; i++) {
                headers.add(rsmd.getColumnLabel(i));
            }
            return headers;
        } catch (SQLException ex) {
            System.err.println(ex.toString());
            return null;
        }
    }
}