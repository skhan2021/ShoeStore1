<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.ProductDAO" %>
<%@ page import="java.util.Optional" %>
<%
    // Get product ID from request parameter, default to 1
    String productIdParam = request.getParameter("productId");
    int productId = 1;
    if (productIdParam != null && !productIdParam.isEmpty()) {
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            productId = 1;
        }
    }

    // Fetch product from database
    ProductDAO productDAO = new ProductDAO();
    Optional<Product> productOpt = productDAO.get(productId);
    Product product = productOpt.orElse(null);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Order - Sneaker Shop</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 25px 30px;
        }

        .header h2 {
            font-size: 28px;
            margin-bottom: 15px;
        }

        /* Navigation Bar */
        .nav-bar {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .nav-btn {
            padding: 8px 16px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s;
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .nav-btn.active {
            background: white;
            color: #f5576c;
        }

        .content {
            padding: 30px;
        }

        .product-display {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
            padding: 25px;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            border-radius: 12px;
        }

        .product-image {
            flex: 0 0 300px;
        }

        .product-image img {
            width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-size: 28px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        .product-specs {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }

        .spec-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .spec-color {
            background: #e3f2fd;
            color: #1976d2;
        }

        .spec-size {
            background: #fff3e0;
            color: #f57c00;
        }

        .product-description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .product-price {
            font-size: 36px;
            color: #4CAF50;
            font-weight: bold;
            margin-top: 15px;
        }

        .order-form {
            background-color: #fff;
            padding: 30px;
            border: 2px solid #ddd;
            border-radius: 12px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="number"]:focus {
            outline: none;
            border-color: #f5576c;
        }

        button {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
            transition: transform 0.2s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
        }

        .discount-info {
            background: linear-gradient(135deg, #fffbea 0%, #fff3cd 100%);
            border-left: 4px solid #f39c12;
            padding: 20px;
            margin-top: 20px;
            border-radius: 8px;
        }

        .discount-info h4 {
            margin-top: 0;
            color: #f39c12;
        }

        .discount-info ul {
            margin: 10px 0;
            padding-left: 20px;
        }

        .error-message {
            color: red;
            padding: 15px;
            background-color: #ffe6e6;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .product-display {
                flex-direction: column;
            }

            .product-image {
                flex: 1;
            }

            .nav-bar {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>👟 Sneaker Shop - Order Products</h2>
        <div class="nav-bar">
            <a href="<%= request.getContextPath() %>/index.jsp" class="nav-btn">🏠 Home</a>
            <a href="<%= request.getContextPath() %>/admin/products" class="nav-btn">🛍️ Admin Products</a>
            <a href="<%= request.getContextPath() %>/customers" class="nav-btn">👥 Customers</a>
            <a href="<%= request.getContextPath() %>/products.jsp" class="nav-btn active">👟 Order Sneakers</a>
            <a href="<%= request.getContextPath() %>/shoes.jsp" class="nav-btn">🏃 Shoe Orders</a>
            <a href="<%= request.getContextPath() %>/logout" class="nav-btn">🚪 Logout</a>
        </div>
    </div>

    <div class="content">
        <% if (product != null) { %>
        <div class="product-display">
            <div class="product-image">
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>"
                     onerror="this.src='https://via.placeholder.com/300x300?text=Product+Image'">
            </div>
            <div class="product-info">
                <div class="product-name"><%= product.getProductName() %></div>

                <div class="product-specs">
                    <% if (product.getColor() != null && !product.getColor().isEmpty()) { %>
                    <span class="spec-badge spec-color">🎨 <%= product.getColor() %></span>
                    <% } %>
                    <% if (product.getSize() != null && !product.getSize().isEmpty()) { %>
                    <span class="spec-badge spec-size">📏 <%= product.getSize() %></span>
                    <% } %>
                </div>

                <div class="product-description"><%= product.getDescription() %></div>
                <div class="product-price">$<%= String.format("%.2f", product.getPrice()) %></div>
            </div>
        </div>

        <div class="order-form">
            <h3>Place Your Order</h3>
            <form action="product-order" method="post">
                <input type="hidden" name="productId" value="<%= product.getProductID() %>">
                <input type="hidden" name="productName" value="<%= product.getProductName() %>">
                <input type="hidden" name="unitPrice" value="<%= product.getPrice() %>">

                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" min="1" value="1" required>
                </div>

                <button type="submit">Calculate Total & Place Order</button>
            </form>

            <div class="discount-info">
                <h4>💰 Quantity Discounts Available!</h4>
                <ul>
                    <li><strong>Buy 5-9 items:</strong> Get 5% off!</li>
                    <li><strong>Buy 10+ items:</strong> Get 10% off!</li>
                </ul>
            </div>
        </div>
        <% } else { %>
        <div class="error-message">
            <strong>Error:</strong> Product not found. Please select a valid product.
        </div>
        <% } %>

        <%
            java.util.List<Product> allProducts = productDAO.getAll();
            if (allProducts != null && allProducts.size() > 1) {
        %>
        <div style="margin-top: 30px; padding: 20px; background: #f8f9fa; border-radius: 8px;">
            <h3 style="margin-bottom: 15px;">Browse Other Products:</h3>
            <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                <% for (Product p : allProducts) { %>
                <a href="products.jsp?productId=<%= p.getProductID() %>"
                   style="padding: 10px 20px; background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                                      color: white; text-decoration: none; border-radius: 8px; font-weight: 600;">
                    <%= p.getProductName() %>
                </a>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
