<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shoe Order</title>
</head>
<body>
<h2>Order Shoes</h2>

<form action="shoe-product" method="post">
    <label for="productName">Shoe Name:</label>
    <input type="text" id="productName" name="productName" required><br><br>

    <label for="unitPrice">Unit Price ($):</label>
    <input type="number" id="unitPrice" name="unitPrice" step="0.01" required><br><br>

    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" min="1" required><br><br>

    <button type="submit">Calculate Total</button>
</form>

</body>
</html>

