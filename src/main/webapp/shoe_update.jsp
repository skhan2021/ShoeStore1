<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Get existing order data from session if it exists
    String productName = (String) session.getAttribute("shoe_productName");
    String unitPrice = (String) session.getAttribute("shoe_unitPrice");
    String quantity = (String) session.getAttribute("shoe_quantity");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Shoe Order</title>
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
            text-align: center;
        }

        .header h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 16px;
            opacity: 0.9;
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

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border-left: 4px solid #17a2b8;
        }

        .current-order-display {
            background: linear-gradient(135deg, #e0f7ff 0%, #c2e9fb 100%);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            border: 2px solid #4facfe;
        }

        .current-order-display h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }

        .order-detail-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid rgba(79, 172, 254, 0.3);
        }

        .order-detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #555;
        }

        .detail-value {
            color: #333;
            font-weight: 500;
        }

        .form-section {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
        }

        .form-section h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 20px;
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

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        button, .btn {
            flex: 1;
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
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

        .nav-links {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
            text-align: center;
        }

        .nav-links a {
            color: #4facfe;
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
        <h1>✏️ Update Shoe Order</h1>
        <p>Modify your shoe order details</p>
    </div>

    <div class="content">
        <% if (productName != null && unitPrice != null && quantity != null) { %>
        <!-- Show current order -->
        <div class="current-order-display">
            <h3>📋 Current Order Details</h3>
            <div class="order-detail-row">
                <span class="detail-label">Shoe Name:</span>
                <span class="detail-value"><%= productName %></span>
            </div>
            <div class="order-detail-row">
                <span class="detail-label">Unit Price:</span>
                <span class="detail-value">$<%= unitPrice %></span>
            </div>
            <div class="order-detail-row">
                <span class="detail-label">Quantity:</span>
                <span class="detail-value"><%= quantity %></span>
            </div>
        </div>

        <!-- Update Form with pre-filled values -->
        <div class="form-section">
            <h3>Update Order Information</h3>
            <form action="shoe-product" method="post">
                <input type="hidden" name="action" value="update">

                <div class="form-group">
                    <label for="productName">Shoe Name:</label>
                    <input type="text" id="productName" name="productName"
                           value="<%= productName %>" required>
                </div>

                <div class="form-group">
                    <label for="unitPrice">Unit Price ($):</label>
                    <input type="number" id="unitPrice" name="unitPrice"
                           step="0.01" value="<%= unitPrice %>" required>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity"
                           min="1" value="<%= quantity %>" required>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-primary">Update Order</button>
                    <a href="<%= request.getContextPath() %>/shoes.jsp" class="btn btn-secondary">Cancel</a>
                </div>
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
        <!-- No order in session - prompt to create one -->
        <div class="alert alert-info">
            <strong>ℹ️ No Order to Update</strong><br>
            You need to create a shoe order first before you can update it.
            Please go to the order page to create a new order.
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <a href="<%= request.getContextPath() %>/shoes.jsp"
               class="btn btn-primary" style="display: inline-block;">
                Create New Order
            </a>
        </div>
        <% } %>

        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/index.jsp">🏠 Home</a>
            <a href="<%= request.getContextPath() %>/shoes.jsp">👟 Order Shoes</a>
            <a href="<%= request.getContextPath() %>/shoe_delete.jsp">🗑️ Delete Order</a>
        </div>
    </div>
</div>
</body>
</html>