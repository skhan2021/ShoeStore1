package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * UPDATED Servlet to handle shoe product orders
 * Now supports both CREATE and UPDATE operations
 *
 * @author Student
 */
@WebServlet(name = "ShoeProductServlet", value = "/shoe-product")
public class ShoeProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Check if this is an update action
        String action = request.getParameter("action");

        String productName = request.getParameter("productName");
        String unitPriceStr = request.getParameter("unitPrice");
        String quantityStr = request.getParameter("quantity");

        double unitPrice = Double.parseDouble(unitPriceStr);
        int quantity = Integer.parseInt(quantityStr);

        double subtotal = unitPrice * quantity;

        double discountPercent = 0.0;
        if (quantity >= 10) {
            discountPercent = 10.0;      // 10+ items → 10%
        } else if (quantity >= 5) {
            discountPercent = 5.0;       // 5–9 items → 5%
        }

        double discountAmount = subtotal * (discountPercent / 100.0);
        double total = subtotal - discountAmount;

        // Store order data in session for update/delete functionality
        session.setAttribute("shoe_productName", productName);
        session.setAttribute("shoe_unitPrice", String.format("%.2f", unitPrice));
        session.setAttribute("shoe_quantity", String.valueOf(quantity));
        session.setAttribute("shoe_subtotal", String.format("%.2f", subtotal));
        session.setAttribute("shoe_discountPercent", String.format("%.0f", discountPercent));
        session.setAttribute("shoe_discountAmount", String.format("%.2f", discountAmount));
        session.setAttribute("shoe_total", String.format("%.2f", total));

        // Put values on request for JSP display
        request.setAttribute("productName", productName);
        request.setAttribute("unitPrice", unitPrice);
        request.setAttribute("quantity", quantity);
        request.setAttribute("discountPercent", discountPercent);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("total", total);

        // Set appropriate message based on action
        if ("update".equals(action)) {
            request.setAttribute("actionMessage", "Order Updated Successfully!");
        } else {
            request.setAttribute("actionMessage", "Order Created Successfully!");
        }

        // Forward to result JSP
        request.getRequestDispatcher("/shoeResult.jsp")
                .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to shoes page if accessed via GET
        response.sendRedirect("shoes.jsp");
    }
}