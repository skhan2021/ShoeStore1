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
    <title>Shoe Order</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 30px;
        }

        .header h2 {
            font-size: 32px;
            margin-bottom: 15px;
        }

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
            color: #4facfe;
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

        .form-section {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input:focus {
            outline: none;
            border-color: #4facfe;
        }

        button {
            width: 100%;
            padding: 15px 30px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
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
            margin-bottom: 10px;
        }

        .discount-info ul {
            margin: 10px 0;
            padding-left: 20px;
        }

        .discount-info li {
            margin: 5px 0;
            color: #856404;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
        }

        .quick-action-btn {
            padding: 12px;
            border-radius: 8px;
            text-decoration: none;
            text-align: center;
            font-weight: 600;
            transition: all 0.3s;
        }

        .quick-action-btn.update {
            background: #ffc107;
            color: #000;
        }

        .quick-action-btn.update:hover {
            background: #ffb300;
            transform: translateY(-2px);
        }

        .quick-action-btn.delete {
            background: #dc3545;
            color: white;
        }

        .quick-action-btn.delete:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>👟 Order Shoes</h2>
        <div class="nav-bar">
            <a href="<%= request.getContextPath() %>/index.jsp" class="nav-btn">🏠 Home</a>
            <a href="<%= request.getContextPath() %>/admin/products" class="nav-btn">🛍️ Admin Products</a>
            <a href="<%= request.getContextPath() %>/customers" class="nav-btn">👥 Customers</a>
            <a href="<%= request.getContextPath() %>/products.jsp" class="nav-btn">👟 Order Sneakers</a>
            <a href="<%= request.getContextPath() %>/shoes.jsp" class="nav-btn active">🏃 Shoe Orders</a>
            <a href="<%= request.getContextPath() %>/logout" class="nav-btn">🚪 Logout</a>
        </div>
    </div>

    <div class="content">
        <!-- Success Message -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">
                    ${sessionScope.message}
                <c:remove var="message" scope="session"/>
            </div>
        </c:if>

        <div class="form-section">
            <h3 style="margin-bottom: 20px; color: #333;">Create New Shoe Order</h3>
            <form action="shoe-product" method="post">
                <div class="form-group">
                    <label for="productName">Shoe Name:</label>
                    <input type="text" id="productName" name="productName"
                           placeholder="e.g., Nike Air Jordan, Adidas Ultraboost" required>
                </div>

                <div class="form-group">
                    <label for="unitPrice">Unit Price ($):</label>
                    <input type="number" id="unitPrice" name="unitPrice"
                           step="0.01" placeholder="0.00" required>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity"
                           min="1" placeholder="1" required>
                </div>

                <button type="submit">Calculate Total & Create Order</button>
            </form>

            <div class="discount-info">
                <h4>💰 Quantity Discounts Available!</h4>
                <ul>
                    <li><strong>Buy 5-9 items:</strong> Get 5% off!</li>
                    <li><strong>Buy 10+ items:</strong> Get 10% off!</li>
                </ul>
            </div>
        </div>

        <%
            // Check if there's an existing order in session
            String existingProductName = (String) session.getAttribute("shoe_productName");
            if (existingProductName != null) {
        %>
        <div class="quick-actions">
            <a href="<%= request.getContextPath() %>/shoe_update.jsp"
               class="quick-action-btn update">
                ✏️ Update Current Order
            </a>
            <a href="<%= request.getContextPath() %>/shoe_delete.jsp"
               class="quick-action-btn delete">
                🗑️ Delete Current Order
            </a>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>