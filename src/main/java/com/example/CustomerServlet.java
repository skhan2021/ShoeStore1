package com.example;

import entity.Customer;
import entity.CustomerDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        // use your existing DAO
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get all customers from the DB via DAO
        List<Customer> customers = customerDAO.getAll();
        request.setAttribute("customers", customers);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("/customers.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Simple “create” operation
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String favoriteMeal = request.getParameter("favoriteMeal");

        if (firstName != null && lastName != null && favoriteMeal != null
                && !firstName.isBlank() && !lastName.isBlank()) {

            Customer c = new Customer();
            c.setFirstName(firstName);
            c.setLastName(lastName);
            c.setFavoriteMeal(favoriteMeal);

            customerDAO.insert(c);    // uses your existing DAO
        }

        // Redirect to avoid form resubmission
        response.sendRedirect(request.getContextPath() + "/customers");
    }
}

