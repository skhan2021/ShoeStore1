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
    <title>Create Product</title>
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
            max-width: 800px;
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
            border-color: #667eea;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group input[type="number"] {
            -moz-appearance: textfield;
        }

        .form-group input[type="number"]::-webkit-inner-spin-button,
        .form-group input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
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

        .form-hint {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }

        .nav-links {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
            text-align: center;
        }

        .nav-links a {
            color: #667eea;
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
        <h1>➕ Create New Product</h1>
    </div>

    <div class="content">
        <!-- Success/Error Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <!-- Create Product Form -->
        <form action="${pageContext.request.contextPath}/product-crud" method="post">
            <input type="hidden" name="action" value="create">

            <div class="form-group">
                <label for="productName">Product Name <span class="required">*</span></label>
                <input type="text" id="productName" name="productName" required
                       placeholder="e.g., Nike Air Max 270">
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description"
                          placeholder="Enter detailed product description..."></textarea>
                <div class="form-hint">Optional: Provide details about the product features</div>
            </div>

            <div class="form-group">
                <label for="color">Color</label>
                <input type="text" id="color" name="color"
                       placeholder="e.g., Black/White, Red, Blue">
                <div class="form-hint">Optional: Specify the product color</div>
            </div>

            <div class="form-group">
                <label for="size">Size</label>
                <input type="text" id="size" name="size"
                       placeholder="e.g., US 10, Medium, Large">
                <div class="form-hint">Optional: Specify the product size</div>
            </div>

            <div class="form-group">
                <label for="price">Price ($) <span class="required">*</span></label>
                <input type="number" id="price" name="price" step="0.01" min="0" required
                       placeholder="0.00">
                <div class="form-hint">Enter price in USD (e.g., 150.00)</div>
            </div>

            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="url" id="imageUrl" name="imageUrl"
                       placeholder="https://example.com/image.jpg">
                <div class="form-hint">Optional: Provide a direct link to the product image</div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Create Product</button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Cancel</a>
            </div>
        </form>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp">🏠 Home</a>
            <a href="${pageContext.request.contextPath}/admin/products">📋 View All Products</a>
            <a href="${pageContext.request.contextPath}/product_read.jsp">🔍 Read Product</a>
        </div>
    </div>
</div>
</body>
</html>