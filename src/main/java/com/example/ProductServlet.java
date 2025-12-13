package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet to handle product orders with quantity-based discounts
 * - Quantity 5-9: 5% discount
 * - Quantity 10+: 10% discount
 *
 * @author Student
 */
@WebServlet(name = "ProductServlet", value = "/product-order")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the form
        String productIdStr = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String unitPriceStr = request.getParameter("unitPrice");
        String quantityStr = request.getParameter("quantity");

        // Parse numeric values
        int productId = Integer.parseInt(productIdStr);
        double unitPrice = Double.parseDouble(unitPriceStr);
        int quantity = Integer.parseInt(quantityStr);

        // Calculate subtotal
        double subtotal = unitPrice * quantity;

        // Apply discount based on quantity
        double discountPercent = 0.0;
        if (quantity >= 10) {
            discountPercent = 10.0;      // 10+ items → 10% discount
        } else if (quantity >= 5) {
            discountPercent = 5.0;       // 5-9 items → 5% discount
        }
        // else: no discount (0%)

        // Calculate discount amount and final total
        double discountAmount = subtotal * (discountPercent / 100.0);
        double total = subtotal - discountAmount;

        // Calculate savings message
        String savingsMessage = "";
        if (discountPercent > 0) {
            savingsMessage = String.format("You saved $%.2f with your quantity discount!", discountAmount);
        }

        // Set attributes to be displayed on the result page
        request.setAttribute("productId", productId);
        request.setAttribute("productName", productName);
        request.setAttribute("unitPrice", unitPrice);
        request.setAttribute("quantity", quantity);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discountPercent", discountPercent);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("total", total);
        request.setAttribute("savingsMessage", savingsMessage);

        // Forward to the result JSP page
        request.getRequestDispatcher("/productResult.jsp")
                .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to products page if accessed via GET
        response.sendRedirect("products.jsp");
    }
}