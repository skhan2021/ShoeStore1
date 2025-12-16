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
    String subtotal = (String) session.getAttribute("shoe_subtotal");
    String total = (String) session.getAttribute("shoe_total");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Shoe Order</title>
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
            max-width: 700px;
            margin: 50px auto;
            background-color: white;
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

        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .warning-section {
            background: #fff3cd;
            border: 3px solid #dc3545;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 20px;
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

        .order-summary {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin: 20px 0;
        }

        .order-summary h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .order-detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .order-detail-row:last-child {
            border-bottom: none;
            border-top: 2px solid #333;
            margin-top: 10px;
            padding-top: 15px;
            font-weight: bold;
        }

        .detail-label {
            font-weight: 600;
            color: #555;
        }

        .detail-value {
            color: #333;
            font-weight: 500;
        }

        .detail-value.price {
            color: #28a745;
            font-size: 18px;
            font-weight: 700;
        }

        .confirmation-text {
            background: #f8d7da;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            font-size: 16px;
            color: #721c24;
            text-align: center;
            font-weight: 600;
            border: 2px solid #dc3545;
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

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
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
        <h1>🗑️ Delete Shoe Order</h1>
        <p>Remove your shoe order</p>
    </div>

    <div class="content">
        <% if (productName != null && unitPrice != null && quantity != null) { %>
        <!-- Show order details with delete confirmation -->
        <div class="warning-section">
            <div class="warning-header">
                <div class="warning-icon">⚠️</div>
                <div class="warning-title">
                    <h2>Confirm Deletion</h2>
                    <p>This action cannot be undone!</p>
                </div>
            </div>

            <div class="order-summary">
                <h3>📋 Order to be Deleted:</h3>
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
                    <span class="detail-value"><%= quantity %> items</span>
                </div>
                <% if (subtotal != null) { %>
                <div class="order-detail-row">
                    <span class="detail-label">Subtotal:</span>
                    <span class="detail-value">$<%= subtotal %></span>
                </div>
                <% } %>
                <% if (total != null) { %>
                <div class="order-detail-row">
                    <span class="detail-label">Total:</span>
                    <span class="detail-value price">$<%= total %></span>
                </div>
                <% } %>
            </div>

            <div class="confirmation-text">
                ⚠️ Are you absolutely sure you want to delete this order?<br>
                All order data will be permanently removed from the session.
            </div>

            <form action="<%= request.getContextPath() %>/shoe-delete" method="post">
                <div class="button-group">
                    <button type="submit" class="btn-danger"
                            onclick="return confirm('Final confirmation: Delete this order permanently?')">
                        🗑️ Yes, Delete Order
                    </button>
                    <a href="<%= request.getContextPath() %>/shoes.jsp" class="btn btn-secondary">
                        ❌ Cancel - Keep Order
                    </a>
                </div>
            </form>
        </div>
        <% } else { %>
        <!-- No order in session -->
        <div class="alert alert-info">
            <strong>ℹ️ No Order to Delete</strong><br>
            There is no shoe order in your current session.
            Please create an order first if you want to delete one.
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <a href="<%= request.getContextPath() %>/shoes.jsp"
               class="btn" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; display: inline-block;">
                Create New Order
            </a>
        </div>
        <% } %>

        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/index.jsp">🏠 Home</a>
            <a href="<%= request.getContextPath() %>/shoes.jsp">👟 Order Shoes</a>
            <a href="<%= request.getContextPath() %>/shoe_update.jsp">✏️ Update Order</a>
        </div>
    </div>
</div>
</body>
</html>