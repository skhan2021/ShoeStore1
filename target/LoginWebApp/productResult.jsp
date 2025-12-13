<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Summary - Sneaker Shop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        h2 {
            color: #333;
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
            text-align: center;
        }
        .success-icon {
            text-align: center;
            font-size: 48px;
            color: #4CAF50;
            margin: 20px 0;
        }
        .order-details {
            background-color: #f9f9f9;
            padding: 25px;
            border-radius: 8px;
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
        }
        .detail-label {
            font-weight: bold;
            color: #555;
        }
        .detail-value {
            color: #333;
        }
        .product-name {
            color: #4CAF50;
            font-size: 18px;
        }
        .subtotal-section {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px solid #ddd;
        }
        .discount-applied {
            color: #f39c12;
            font-weight: bold;
        }
        .total-section {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            text-align: center;
        }
        .total-label {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .total-amount {
            font-size: 36px;
            font-weight: bold;
        }
        .savings-badge {
            background-color: #fffbea;
            border-left: 4px solid #f39c12;
            padding: 15px;
            margin: 20px 0;
            border-radius: 4px;
            text-align: center;
        }
        .savings-badge strong {
            color: #f39c12;
            font-size: 18px;
        }
        .actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .button {
            flex: 1;
            padding: 15px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            font-size: 16px;
        }
        .button-primary {
            background-color: #4CAF50;
            color: white;
        }
        .button-primary:hover {
            background-color: #45a049;
        }
        .button-secondary {
            background-color: #f1f1f1;
            color: #333;
            border: 2px solid #ddd;
        }
        .button-secondary:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="success-icon">✓</div>
    <h2>Order Summary</h2>

    <div class="order-details">
        <div class="detail-row">
            <span class="detail-label">Product:</span>
            <span class="detail-value product-name">${productName}</span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Unit Price:</span>
            <span class="detail-value">$<c:out value="${String.format('%.2f', unitPrice)}" /></span>
        </div>
        <div class="detail-row">
            <span class="detail-label">Quantity:</span>
            <span class="detail-value">${quantity} items</span>
        </div>

        <div class="subtotal-section">
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
        </div>
    </div>

    <c:if test="${not empty savingsMessage}">
        <div class="savings-badge">
            <strong>🎉 ${savingsMessage}</strong>
        </div>
    </c:if>

    <div class="total-section">
        <div class="total-label">Total Amount</div>
        <div class="total-amount">$<c:out value="${String.format('%.2f', total)}" /></div>
    </div>

    <div class="actions">
        <a href="products.jsp?productId=${productId}" class="button button-primary">Order More</a>
        <a href="index.jsp" class="button button-secondary">Back to Home</a>
    </div>
</div>
</body>
</html>
