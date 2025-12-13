package com.example;

import entity.Product;
import entity.ProductDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

/**
 * Admin servlet for managing products (CRUD operations)
 * @author Student
 */
@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in (basic security)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "list":
            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            updateProduct(request, response);
        } else {
            // Default: create new product
            createProduct(request, response);
        }
    }

    /**
     * List all products
     */
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAll();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/adminProducts.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Show edit form for a product
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Optional<Product> productOpt = productDAO.get(id);
        
        if (productOpt.isPresent()) {
            request.setAttribute("product", productOpt.get());
            request.setAttribute("editMode", true);
        }
        
        List<Product> products = productDAO.getAll();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/adminProducts.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Create a new product
     */
    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("productName");
        String description = request.getParameter("description");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");

        if (name != null && !name.isBlank() && priceStr != null) {
            try {
                double price = Double.parseDouble(priceStr);
                
                Product product = new Product();
                product.setProductName(name);
                product.setDescription(description != null ? description : "");
                product.setColor(color != null ? color : "");
                product.setSize(size != null ? size : "");
                product.setPrice(price);
                product.setImageUrl(imageUrl != null && !imageUrl.isBlank() ? 
                    imageUrl : "https://via.placeholder.com/300x300?text=Product");

                productDAO.insert(product);
                
                request.setAttribute("message", "Product added successfully!");
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price format");
            }
        } else {
            request.setAttribute("error", "Please fill in all required fields");
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    /**
     * Update an existing product
     */
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("productName");
        String description = request.getParameter("description");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");

        if (name != null && !name.isBlank() && priceStr != null) {
            try {
                double price = Double.parseDouble(priceStr);
                
                Product product = new Product();
                product.setProductID(id);
                product.setProductName(name);
                product.setDescription(description != null ? description : "");
                product.setColor(color != null ? color : "");
                product.setSize(size != null ? size : "");
                product.setPrice(price);
                product.setImageUrl(imageUrl != null && !imageUrl.isBlank() ? 
                    imageUrl : "https://via.placeholder.com/300x300?text=Product");

                productDAO.update(product);
                
                request.setAttribute("message", "Product updated successfully!");
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price format");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    /**
     * Delete a product
     */
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteById(id);
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
