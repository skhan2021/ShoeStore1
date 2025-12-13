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
    <title>Admin - Product Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
        }

        .header h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Navigation Bar */
        .nav-bar {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .nav-btn {
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .nav-btn.active {
            background: white;
            color: #667eea;
        }

        .content {
            padding: 30px;
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

        .section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #667eea;
        }

        /* Form Styles */
        .product-form {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .form-group label .required {
            color: #dc3545;
        }

        .form-group input,
        .form-group textarea {
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .btn {
            padding: 12px 30px;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
        }

        tbody tr {
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product-name {
            font-weight: 600;
            color: #333;
        }

        .product-price {
            font-size: 18px;
            font-weight: 700;
            color: #28a745;
        }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-color {
            background: #e3f2fd;
            color: #1976d2;
        }

        .badge-size {
            background: #fff3e0;
            color: #f57c00;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-small {
            padding: 6px 12px;
            font-size: 13px;
            border-radius: 6px;
        }

        .btn-edit {
            background: #ffc107;
            color: #000;
        }

        .btn-edit:hover {
            background: #ffb300;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background: #c82333;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
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
        <h1>🛍️ Product Management</h1>
        <div class="nav-bar">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-btn">🏠 Home</a>
            <a href="${pageContext.request.contextPath}/admin/products" class="nav-btn active">🛍️ Admin Products</a>
            <a href="${pageContext.request.contextPath}/customers" class="nav-btn">👥 Customers</a>
            <a href="${pageContext.request.contextPath}/products.jsp" class="nav-btn">👟 Order Sneakers</a>
            <a href="${pageContext.request.contextPath}/shoes.jsp" class="nav-btn">🏃 Shoe Orders</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-btn">🚪 Logout</a>
        </div>
    </div>

    <div class="content">
        <!-- Success/Error Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <!-- Add/Edit Product Form -->
        <div class="section">
            <h2 class="section-title">
                <c:choose>
                    <c:when test="${editMode}">Edit Product</c:when>
                    <c:otherwise>Add New Product</c:otherwise>
                </c:choose>
            </h2>

            <div class="product-form">
                <form action="${pageContext.request.contextPath}/admin/products" method="post">
                    <c:if test="${editMode}">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="productId" value="${product.productID}">
                    </c:if>

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="productName">Product Name <span class="required">*</span></label>
                            <input type="text" id="productName" name="productName"
                                   value="${product.productName}" required>
                        </div>

                        <div class="form-group">
                            <label for="price">Price ($) <span class="required">*</span></label>
                            <input type="number" id="price" name="price" step="0.01"
                                   value="${product.price}" required>
                        </div>

                        <div class="form-group">
                            <label for="color">Color</label>
                            <input type="text" id="color" name="color"
                                   value="${product.color}" placeholder="e.g., Black/White">
                        </div>

                        <div class="form-group">
                            <label for="size">Size</label>
                            <input type="text" id="size" name="size"
                                   value="${product.size}" placeholder="e.g., US 10">
                        </div>

                        <div class="form-group full-width">
                            <label for="description">Description</label>
                            <textarea id="description" name="description"
                                      placeholder="Enter product description...">${product.description}</textarea>
                        </div>

                        <div class="form-group full-width">
                            <label for="imageUrl">Image URL</label>
                            <input type="url" id="imageUrl" name="imageUrl"
                                   value="${product.imageUrl}"
                                   placeholder="https://example.com/image.jpg">
                        </div>
                    </div>

                    <div class="form-actions">
                        <c:if test="${editMode}">
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Cancel</a>
                        </c:if>
                        <button type="submit" class="btn btn-primary">
                            <c:choose>
                                <c:when test="${editMode}">Update Product</c:when>
                                <c:otherwise>Add Product</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Product List -->
        <div class="section">
            <h2 class="section-title">Product Inventory</h2>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty products}">
                        <table>
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Product Name</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Price</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="prod" items="${products}">
                                <tr>
                                    <td>${prod.productID}</td>
                                    <td>
                                        <img src="${prod.imageUrl}" alt="${prod.productName}"
                                             class="product-image"
                                             onerror="this.src='https://via.placeholder.com/60x60?text=No+Image'">
                                    </td>
                                    <td class="product-name">${prod.productName}</td>
                                    <td>
                                        <c:if test="${not empty prod.color}">
                                            <span class="badge badge-color">${prod.color}</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${not empty prod.size}">
                                            <span class="badge badge-size">${prod.size}</span>
                                        </c:if>
                                    </td>
                                    <td class="product-price">$${String.format("%.2f", prod.price)}</td>
                                    <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis;">
                                            ${prod.description}
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${prod.productID}"
                                               class="btn btn-small btn-edit">Edit</a>
                                            <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${prod.productID}"
                                               class="btn btn-small btn-delete"
                                               onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div style="font-size: 64px; margin-bottom: 20px;">📦</div>
                            <h3>No Products Yet</h3>
                            <p>Add your first product using the form above!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</body>
</html>
