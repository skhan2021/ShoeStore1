<%
    // 'session' is an implicit JSP variable (type HttpSession)
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome - Dashboard</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .header h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 18px;
            opacity: 0.9;
        }

        .content {
            padding: 40px;
        }

        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .nav-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 35px;
            border-radius: 15px;
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: all 0.3s;
            border: 3px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .nav-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .nav-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
            border-color: #667eea;
        }

        .nav-card h3 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #333;
        }

        .nav-card p {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
        }

        .admin-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .admin-card h3,
        .admin-card p {
            color: white;
        }

        .customer-card {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
        }

        .customer-card h3,
        .customer-card p {
            color: white;
        }

        .product-card {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .product-card h3,
        .product-card p {
            color: white;
        }

        .shoe-card {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .shoe-card h3,
        .shoe-card p {
            color: white;
        }

        .logout-section {
            text-align: center;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #e0e0e0;
        }

        .logout-btn {
            display: inline-block;
            padding: 15px 40px;
            background: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s;
        }

        .logout-btn:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(220, 53, 69, 0.4);
        }

        @media (max-width: 768px) {
            .nav-grid {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Welcome, <%= session.getAttribute("user") %>!</h1>
        <p>Choose where you'd like to go</p>
    </div>

    <div class="content">
        <div class="nav-grid">
            <a href="<%= request.getContextPath() %>/admin/products" class="nav-card admin-card">
                <h3>Admin Products</h3>
                <p>Manage your product inventory, add new products, edit details, and remove items</p>
            </a>

            <a href="<%= request.getContextPath() %>/customers" class="nav-card customer-card">
                <h3>Customer Management</h3>
                <p>View and manage your customer database, add new customers</p>
            </a>

            <a href="<%= request.getContextPath() %>/products.jsp" class="nav-card product-card">
                <h3>Order Sneakers</h3>
                <p>Browse sneaker catalog and place orders with quantity discounts</p>
            </a>

            <a href="<%= request.getContextPath() %>/shoes.jsp" class="nav-card shoe-card">
                <h3>Shoe Orders</h3>
                <p>Place custom shoe orders and calculate prices</p>
            </a>
        </div>

        <div class="logout-section">
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
        </div>
    </div>
</div>
</body>
</html>