package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet to handle shoe order deletion
 * Removes order data from session
 *
 * @author Student
 */
@WebServlet(name = "ShoeDeleteServlet", value = "/shoe-delete")
public class ShoeDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get order details before deleting (for confirmation message)
        String productName = (String) session.getAttribute("shoe_productName");

        // Remove all shoe order data from session
        session.removeAttribute("shoe_productName");
        session.removeAttribute("shoe_unitPrice");
        session.removeAttribute("shoe_quantity");
        session.removeAttribute("shoe_subtotal");
        session.removeAttribute("shoe_discountPercent");
        session.removeAttribute("shoe_discountAmount");
        session.removeAttribute("shoe_total");

        // Set success message
        if (productName != null) {
            session.setAttribute("message",
                    "Order for '" + productName + "' has been deleted successfully!");
        } else {
            session.setAttribute("message", "Order has been deleted successfully!");
        }

        // Redirect to shoes page
        response.sendRedirect(request.getContextPath() + "/shoes.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to delete page
        response.sendRedirect(request.getContextPath() + "/shoe_delete.jsp");
    }
}