<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Read Product</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
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
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
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

        .form-group {
            margin-bottom: 20px;
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
            border-color: #11998e;
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
        }

        .btn-primary {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(17, 153, 142, 0.4);
        }

        .product-display {
            display: none;
            background: #fff;
            border: 2px solid #11998e;
            border-radius: 12px;
            padding: 30px;
            margin-top: 30px;
        }

        .product-display.show {
            display: block;
        }

        .product-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }

        .product-image {
            flex: 0 0 200px;
        }

        .product-image img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .product-title {
            flex: 1;
        }

        .product-title h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }

        .product-id {
            font-size: 14px;
            color: #666;
            font-weight: 600;
        }

        .product-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .detail-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .detail-label {
            font-size: 12px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .detail-value {
            font-size: 16px;
            color: #333;
            font-weight: 500;
        }

        .detail-value.price {
            font-size: 24px;
            color: #28a745;
            font-weight: 700;
        }

        .detail-item.full-width {
            grid-column: 1 / -1;
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            margin-right: 10px;
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
            color: #11998e;
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
        <h1>🔍 Read Product Details</h1>
    </div>

    <div class="content">
        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <!-- Search Form -->
        <div class="search-section">
            <h3 style="margin-bottom: 20px; color: #333;">Search Product by ID</h3>
            <form action="${pageContext.request.contextPath}/product-crud" method="post">
                <input type="hidden" name="action" value="read">

                <div class="form-group">
                    <label for="productId">Product ID</label>
                    <input type="number" id="productId" name="productId" min="1" required
                           placeholder="Enter product ID (e.g., 1, 2, 3...)">
                </div>

                <button type="submit" class="btn btn-primary">Search Product</button>
            </form>
        </div>

        <!-- Product Display (shown after search) -->
        <c:if test="${not empty product}">
            <div class="product-display show">
                <div class="product-header">
                    <div class="product-image">
                        <img src="${product.imageUrl}" alt="${product.productName}"
                             onerror="this.src='https://via.placeholder.com/200x200?text=No+Image'">
                    </div>
                    <div class="product-title">
                        <h2>${product.productName}</h2>
                        <p class="product-id">Product ID: ${product.productID}</p>
                    </div>
                </div>

                <div class="product-details">
                    <div class="detail-item">
                        <div class="detail-label">Price</div>
                        <div class="detail-value price">$${String.format("%.2f", product.price)}</div>
                    </div>

                    <div class="detail-item">
                        <div class="detail-label">Color & Size</div>
                        <div class="detail-value">
                            <c:if test="${not empty product.color}">
                                <span class="badge badge-color">${product.color}</span>
                            </c:if>
                            <c:if test="${not empty product.size}">
                                <span class="badge badge-size">${product.size}</span>
                            </c:if>
                            <c:if test="${empty product.color and empty product.size}">
                                <span style="color: #999;">Not specified</span>
                            </c:if>
                        </div>
                    </div>

                    <div class="detail-item full-width">
                        <div class="detail-label">Description</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${not empty product.description}">
                                    ${product.description}
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #999;">No description available</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="detail-item full-width">
                        <div class="detail-label">Image URL</div>
                        <div class="detail-value" style="word-break: break-all; font-size: 14px;">
                            <c:choose>
                                <c:when test="${not empty product.imageUrl}">
                                    ${product.imageUrl}
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #999;">No image URL</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 30px; display: flex; gap: 15px;">
                    <a href="${pageContext.request.contextPath}/product_update.jsp?id=${product.productID}"
                       class="btn btn-primary" style="flex: 1; text-align: center;">
                        Edit This Product
                    </a>
                    <a href="${pageContext.request.contextPath}/product_delete.jsp?id=${product.productID}"
                       class="btn" style="flex: 1; text-align: center; background: #dc3545; color: white;">
                        Delete This Product
                    </a>
                </div>
            </div>
        </c:if>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp">🏠 Home</a>
            <a href="${pageContext.request.contextPath}/admin/products">📋 View All Products</a>
            <a href="${pageContext.request.contextPath}/product_create.jsp">➕ Create Product</a>
        </div>
    </div>
</div>
</body>
</html>