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
    <title>Update Product</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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

        .update-section {
            background: #fff;
            border: 2px solid #f5576c;
            border-radius: 12px;
            padding: 30px;
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

        .form-group label .required {
            color: #dc3545;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #f5576c;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
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

        .btn-primary {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
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

        .product-preview {
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .preview-image {
            flex: 0 0 120px;
        }

        .preview-image img {
            width: 100%;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }

        .preview-info h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 5px;
        }

        .preview-info p {
            color: #666;
            font-size: 14px;
        }

        .nav-links {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
            text-align: center;
        }

        .nav-links a {
            color: #f5576c;
            text-decoration: none;
            font-weight: 600;
            margin: 0 15px;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }

        .form-hint {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>✏️ Update Product</h1>
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
            <h3 style="margin-bottom: 20px; color: #333;">Find Product to Update</h3>
            <form action="${pageContext.request.contextPath}/product_update.jsp" method="get">
                <div class="form-group">
                    <label for="productId">Product ID</label>
                    <input type="number" id="productId" name="id" min="1" required
                           placeholder="Enter product ID">
                </div>
                <button type="submit" class="btn btn-primary">Load Product</button>
            </form>
        </div>
        <% } else { %>
        <!-- Update Form (shown when product is loaded) -->
        <div class="product-preview">
            <div class="preview-image">
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>"
                     onerror="this.src='https://via.placeholder.com/120x120?text=No+Image'">
            </div>
            <div class="preview-info">
                <h3><%= product.getProductName() %></h3>
                <p>Product ID: <%= product.getProductID() %> | Current Price: $<%= String.format("%.2f", product.getPrice()) %></p>
            </div>
        </div>

        <div class="update-section">
            <h3 style="margin-bottom: 20px; color: #333;">Edit Product Information</h3>
            <form action="${pageContext.request.contextPath}/product-crud" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="productId" value="<%= product.getProductID() %>">

                <div class="form-grid">
                    <div class="form-group">
                        <label for="productName">Product Name <span class="required">*</span></label>
                        <input type="text" id="productName" name="productName" required
                               value="<%= product.getProductName() %>">
                    </div>

                    <div class="form-group">
                        <label for="price">Price ($) <span class="required">*</span></label>
                        <input type="number" id="price" name="price" step="0.01" min="0" required
                               value="<%= product.getPrice() %>">
                    </div>

                    <div class="form-group">
                        <label for="color">Color</label>
                        <input type="text" id="color" name="color"
                               value="<%= product.getColor() != null ? product.getColor() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="size">Size</label>
                        <input type="text" id="size" name="size"
                               value="<%= product.getSize() != null ? product.getSize() : "" %>">
                    </div>

                    <div class="form-group full-width">
                        <label for="description">Description</label>
                        <textarea id="description" name="description"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label for="imageUrl">Image URL</label>
                        <input type="url" id="imageUrl" name="imageUrl"
                               value="<%= product.getImageUrl() != null ? product.getImageUrl() : "" %>">
                        <div class="form-hint">Provide a direct link to the product image</div>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Update Product</button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Cancel</a>
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