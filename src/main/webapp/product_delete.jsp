<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.ProductDAO" %>
<%@ page import="java.util.Optional" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Get product ID from parameter
    String productIdParam = request.getParameter("id");
    Product product = null;
    if (productIdParam != null && !productIdParam.isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdParam);
            ProductDAO productDAO = new ProductDAO();
            Optional<Product> productOpt = productDAO.get(productId);
            if (productOpt.isPresent()) {
                product = productOpt.get();
            }
        } catch (NumberFormatException e) {
            // Invalid ID
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Product</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #fc4a1a 0%, #f7b733 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #fc4a1a 0%, #f7b733 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 32px;
            font-weight: 600;
        }

        .content {
            padding: 40px;
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .search-section {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .delete-section {
            background: #fff3cd;
            border: 3px solid #dc3545;
            border-radius: 12px;
            padding: 30px;
        }

        .warning-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 2px solid #dc3545;
        }

        .warning-icon {
            font-size: 48px;
            color: #dc3545;
        }

        .warning-title {
            flex: 1;
        }

        .warning-title h2 {
            color: #dc3545;
            font-size: 24px;
            margin-bottom: 5px;
        }

        .warning-title p {
            color: #721c24;
            font-size: 14px;
        }

        .product-info {
            background: white;
            padding: 25px;
            border-radius: 8px;
            margin: 20px 0;
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .product-image {
            flex: 0 0 150px;
        }

        .product-image img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .product-details {
            flex: 1;
        }

        .product-details h3 {
            font-size: 22px;
            color: #333;
            margin-bottom: 10px;
        }

        .detail-row {
            display: flex;
            margin: 8px 0;
            font-size: 14px;
        }

        .detail-label {
            font-weight: 600;
            color: #666;
            width: 100px;
        }

        .detail-value {
            color: #333;
        }

        .confirmation-text {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            font-size: 16px;
            color: #721c24;
            text-align: center;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #dc3545;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
            flex: 1;
        }

        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            flex: 1;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            margin-right: 8px;
        }

        .badge-color {
            background: #e3f2fd;
            color: #1976d2;
        }

        .badge-size {
            background: #fff3e0;
            color: #f57c00;
        }

        .nav-links {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
            text-align: center;
        }

        .nav-links a {
            color: #fc4a1a;
            text-decoration: none;
            font-weight: 600;
            margin: 0 15px;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🗑️ Delete Product</h1>
    </div>

    <div class="content">
        <!-- Success/Error Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <% if (product == null) { %>
        <!-- Search Form (shown when no product is loaded) -->
        <div class="search-section">
            <h3 style="margin-bottom: 20px; color: #333;">Find Product to Delete</h3>
            <form action="${pageContext.request.contextPath}/product_delete.jsp" method="get">
                <div class="form-group">
                    <label for="productId">Product ID</label>
                    <input type="number" id="productId" name="id" min="1" required
                           placeholder="Enter product ID">
                </div>
                <button type="submit" class="btn btn-danger">Load Product</button>
            </form>
        </div>
        <% } else { %>
        <!-- Delete Confirmation (shown when product is loaded) -->
        <div class="delete-section">
            <div class="warning-header">
                <div class="warning-icon">⚠️</div>
                <div class="warning-title">
                    <h2>Confirm Deletion</h2>
                    <p>This action cannot be undone!</p>
                </div>
            </div>

            <div class="product-info">
                <div class="product-image">
                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>"
                         onerror="this.src='https://via.placeholder.com/150x150?text=No+Image'">
                </div>
                <div class="product-details">
                    <h3><%= product.getProductName() %></h3>
                    <div class="detail-row">
                        <span class="detail-label">Product ID:</span>
                        <span class="detail-value"><%= product.getProductID() %></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Price:</span>
                        <span class="detail-value" style="color: #28a745; font-weight: 700;">
                                $<%= String.format("%.2f", product.getPrice()) %>
                            </span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Details:</span>
                        <span class="detail-value">
                                <% if (product.getColor() != null && !product.getColor().isEmpty()) { %>
                                    <span class="badge badge-color"><%= product.getColor() %></span>
                                <% } %>
                                <% if (product.getSize() != null && !product.getSize().isEmpty()) { %>
                                    <span class="badge badge-size"><%= product.getSize() %></span>
                                <% } %>
                            </span>
                    </div>
                    <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                    <div class="detail-row" style="margin-top: 10px;">
                        <span class="detail-label">Description:</span>
                        <span class="detail-value" style="flex: 1;">
                                <%= product.getDescription().length() > 100 ?
                                        product.getDescription().substring(0, 100) + "..." :
                                        product.getDescription() %>
                            </span>
                    </div>
                    <% } %>
                </div>
            </div>

            <div class="confirmation-text">
                Are you absolutely sure you want to delete this product?<br>
                All product data will be permanently removed.
            </div>

            <form action="${pageContext.request.contextPath}/product-crud" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="productId" value="<%= product.getProductID() %>">

                <div class="form-actions">
                    <button type="submit" class="btn btn-danger"
                            onclick="return confirm('Final confirmation: Delete this product permanently?')">
                        Yes, Delete Product
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">
                        Cancel - Keep Product
                    </a>
                </div>
            </form>
        </div>
        <% } %>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp">🏠 Home</a>
            <a href="${pageContext.request.contextPath}/admin/products">📋 View All Products</a>
            <a href="${pageContext.request.contextPath}/product_create.jsp">➕ Create Product</a>
            <a href="${pageContext.request.contextPath}/product_read.jsp">🔍 Read Product</a>
        </div>
    </div>
</div>
</body>
</html>