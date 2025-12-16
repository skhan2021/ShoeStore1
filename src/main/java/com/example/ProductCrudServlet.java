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
import java.util.Optional;

/**
 * Servlet to handle HTTP POST CRUD operations for products
 * Supports: Create, Read, Update, Delete
 *
 * @author Student
 */
@WebServlet("/product-crud")
public class ProductCrudServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
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

        // Get the action parameter to determine which operation to perform
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            request.setAttribute("error", "No action specified");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        // Route to appropriate handler based on action
        switch (action.toLowerCase()) {
            case "create":
                handleCreate(request, response);
                break;
            case "read":
                handleRead(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            default:
                request.setAttribute("error", "Invalid action: " + action);
                response.sendRedirect(request.getContextPath() + "/admin/products");
                break;
        }
    }

    /**
     * CREATE: Insert a new product into the database
     */
    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form parameters
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String priceStr = request.getParameter("price");
            String imageUrl = request.getParameter("imageUrl");

            // Validate required fields
            if (productName == null || productName.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Product name is required");
                response.sendRedirect(request.getContextPath() + "/product_create.jsp");
                return;
            }

            if (priceStr == null || priceStr.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Price is required");
                response.sendRedirect(request.getContextPath() + "/product_create.jsp");
                return;
            }

            // Parse price
            double price;
            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) {
                    throw new NumberFormatException("Price cannot be negative");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid price format: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/product_create.jsp");
                return;
            }

            // Create product object
            Product product = new Product();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setColor(color != null ? color.trim() : "");
            product.setSize(size != null ? size.trim() : "");
            product.setPrice(price);
            product.setImageUrl(imageUrl != null && !imageUrl.trim().isEmpty() ?
                    imageUrl.trim() : "https://via.placeholder.com/300x300?text=Product");

            // Insert into database
            productDAO.insert(product);

            // Set success message and redirect
            request.getSession().setAttribute("message",
                    "Product '" + productName + "' created successfully!");
            response.sendRedirect(request.getContextPath() + "/admin/products");

        } catch (Exception e) {
            request.getSession().setAttribute("error",
                    "Error creating product: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/product_create.jsp");
        }
    }

    /**
     * READ: Retrieve and display a product by ID
     */
    private void handleRead(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get product ID parameter
            String productIdStr = request.getParameter("productId");

            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Product ID is required");
                RequestDispatcher rd = request.getRequestDispatcher("/product_read.jsp");
                rd.forward(request, response);
                return;
            }

            // Parse product ID
            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid product ID format");
                RequestDispatcher rd = request.getRequestDispatcher("/product_read.jsp");
                rd.forward(request, response);
                return;
            }

            // Retrieve product from database
            Optional<Product> productOpt = productDAO.get(productId);

            if (productOpt.isPresent()) {
                // Product found - display it
                request.setAttribute("product", productOpt.get());
            } else {
                // Product not found
                request.setAttribute("error", "Product with ID " + productId + " not found");
            }

            // Forward to read page
            RequestDispatcher rd = request.getRequestDispatcher("/product_read.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error reading product: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/product_read.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * UPDATE: Modify an existing product in the database
     */
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get product ID
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Product ID is required");
                response.sendRedirect(request.getContextPath() + "/product_update.jsp");
                return;
            }

            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid product ID format");
                response.sendRedirect(request.getContextPath() + "/product_update.jsp");
                return;
            }

            // Check if product exists
            Optional<Product> existingProductOpt = productDAO.get(productId);
            if (!existingProductOpt.isPresent()) {
                request.getSession().setAttribute("error",
                        "Product with ID " + productId + " not found");
                response.sendRedirect(request.getContextPath() + "/product_update.jsp");
                return;
            }

            // Get form parameters
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String priceStr = request.getParameter("price");
            String imageUrl = request.getParameter("imageUrl");

            // Validate required fields
            if (productName == null || productName.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Product name is required");
                response.sendRedirect(request.getContextPath() +
                        "/product_update.jsp?id=" + productId);
                return;
            }

            if (priceStr == null || priceStr.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Price is required");
                response.sendRedirect(request.getContextPath() +
                        "/product_update.jsp?id=" + productId);
                return;
            }

            // Parse price
            double price;
            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) {
                    throw new NumberFormatException("Price cannot be negative");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid price format: " + e.getMessage());
                response.sendRedirect(request.getContextPath() +
                        "/product_update.jsp?id=" + productId);
                return;
            }

            // Create updated product object
            Product product = new Product();
            product.setProductID(productId);
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setColor(color != null ? color.trim() : "");
            product.setSize(size != null ? size.trim() : "");
            product.setPrice(price);
            product.setImageUrl(imageUrl != null && !imageUrl.trim().isEmpty() ?
                    imageUrl.trim() : "https://via.placeholder.com/300x300?text=Product");

            // Update in database
            productDAO.update(product);

            // Set success message and redirect
            request.getSession().setAttribute("message",
                    "Product '" + productName + "' updated successfully!");
            response.sendRedirect(request.getContextPath() + "/admin/products");

        } catch (Exception e) {
            request.getSession().setAttribute("error",
                    "Error updating product: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/product_update.jsp");
        }
    }

    /**
     * DELETE: Remove a product from the database
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get product ID parameter
            String productIdStr = request.getParameter("productId");

            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Product ID is required");
                response.sendRedirect(request.getContextPath() + "/product_delete.jsp");
                return;
            }

            // Parse product ID
            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid product ID format");
                response.sendRedirect(request.getContextPath() + "/product_delete.jsp");
                return;
            }

            // Check if product exists before deleting
            Optional<Product> productOpt = productDAO.get(productId);
            if (!productOpt.isPresent()) {
                request.getSession().setAttribute("error",
                        "Product with ID " + productId + " not found");
                response.sendRedirect(request.getContextPath() + "/product_delete.jsp");
                return;
            }

            // Get product name for success message
            String productName = productOpt.get().getProductName();

            // Delete from database
            productDAO.deleteById(productId);

            // Set success message and redirect
            request.getSession().setAttribute("message",
                    "Product '" + productName + "' (ID: " + productId + ") deleted successfully!");
            response.sendRedirect(request.getContextPath() + "/admin/products");

        } catch (Exception e) {
            request.getSession().setAttribute("error",
                    "Error deleting product: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/product_delete.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the admin products page
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}