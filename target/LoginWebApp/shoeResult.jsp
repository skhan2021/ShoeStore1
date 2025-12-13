<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shoe Order Summary</title>
</head>
<body>
<h2>Shoe Order Summary</h2>

<p>
    Product: <strong>${productName}</strong><br>
    Unit Price: $${unitPrice}<br>
    Quantity: ${quantity}<br>
</p>

<p>
    Subtotal: $${subtotal}<br>
    Discount: ${discountPercent}% (-$${discountAmount})<br>
    <strong>Total: $${total}</strong>
</p>

<p><a href="shoes.jsp">Back to order page</a></p>

</body>
</html>

