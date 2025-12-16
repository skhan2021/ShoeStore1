<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shoe Order Summary</title>
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
            padding: 40px;
        }

        .success-icon {
            text-align: center;
            font-size: 64px;
            color: #28a745;
            margin-bottom: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .action-message {
            text-align: center;
            color: #28a745;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .order-details {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
            margin: 20px 0;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .detail-row:last-child {
            border-bottom: none;
            border-top: 2px solid #333;
            margin-top: 10px;
            padding-top: 15px;
        }

        .detail-label {
            font-weight: 600;
            color: #555;
        }

        .detail-value {
            color: #333;
            font-weight: 500;
        }

        .discount-applied {
            color: #f39c12;
            font-weight: bold;
        }

        .total-section {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin: 20px 0;
            text-align: center;
        }

        .total-label {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .total-amount {
            font-size: 42px;
            font-weight: bold;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 15px 20px;
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

        .btn-warning {
            background: #ffc107;
            color: #000;
        }

        .btn-warning:hover {
            background: #ffb300;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="success-icon">✓</div>
    <h2>Shoe Order Summary</h2>

    <c:if test="${not empty actionMessage}">
        <div class="action-message">${actionMessage}</div>
    </c:if>

    <div class="order-details">
        <div class="detail-row">
            <span class="detail-label">Product:</span>
            <span class="detail-value"><strong>${productName}</strong></span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Unit Price:</span>
            <span class="detail-value">$<c:out value="${String.format('%.2f', unitPrice)}" /></span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Quantity:</span>
            <span class="detail-value">${quantity} items</span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Subtotal:</span>
            <span class="detail-value">$<c:out value="${String.format('%.2f', subtotal)}" /></span>
        </div>
        <c:if test="${discountPercent > 0}">
            <div class="detail-row">
                <span class="detail-label discount-applied">
                    Discount (<c:out value="${String.format('%.0f', discountPercent)}" />%):
                </span>
                <span class="detail-value discount-applied">
                    -$<c:out value="${String.format('%.2f', discountAmount)}" />
                </span>
            </div>
        </c:if>
        <div class="detail-row">
            <span class="detail-label"><strong>Total:</strong></span>
            <span class="detail-value" style="color: #28a745; font-size: 20px; font-weight: 700;">
                $<c:out value="${String.format('%.2f', total)}" />
            </span>
        </div>
    </div>

    <c:if test="${discountPercent > 0}">
        <div style="background: #d4edda; padding: 15px; border-radius: 8px; text-align: center; color: #155724; font-weight: 600; margin: 20px 0;">
            🎉 You saved $<c:out value="${String.format('%.2f', discountAmount)}" /> with your quantity discount!
        </div>
    </c:if>

    <div class="action-buttons">
        <a href="<%= request.getContextPath() %>/shoes.jsp" class="btn btn-primary">
            Create New Order
        </a>
        <a href="<%= request.getContextPath() %>/shoe_update.jsp" class="btn btn-warning">
            ✏️ Update Order
        </a>
        <a href="<%= request.getContextPath() %>/shoe_delete.jsp" class="btn btn-danger">
            🗑️ Delete Order
        </a>
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-secondary">
            🏠 Back to Home
        </a>
    </div>
</div>
</body>
</html>