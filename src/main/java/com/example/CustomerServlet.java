package com.example;

import entity.Customer;
import entity.CustomerDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteCustomer(request, response);
            return;
        }

        // Default: list all customers
        listCustomers(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Create new customer
        createCustomer(request, response);
    }

    /**
     * List all customers
     */
    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> customers = customerDAO.getAll();
        request.setAttribute("customers", customers);
        RequestDispatcher rd = request.getRequestDispatcher("/customers.jsp");
        rd.forward(request, response);
    }

    /**
     * Create a new customer
     */
    private void createCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String favoriteMeal = request.getParameter("favoriteMeal");

        if (firstName != null && lastName != null && favoriteMeal != null
                && !firstName.isBlank() && !lastName.isBlank()) {

            // Get next available ID
            int nextId = getNextCustomerId();

            Customer customer = new Customer();
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setFavoriteMeal(favoriteMeal);

            // Create a new customer with the ID
            Customer newCustomer = new Customer(nextId, firstName, lastName, favoriteMeal);
            customerDAO.insert(newCustomer);

            request.getSession().setAttribute("message", "Customer added successfully!");
        } else {
            request.getSession().setAttribute("error", "Please fill in all required fields");
        }

        // Redirect to avoid form resubmission
        response.sendRedirect(request.getContextPath() + "/customers");
    }

    /**
     * Delete a customer
     */
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Optional<Customer> customerOpt = customerDAO.get(id);

                if (customerOpt.isPresent()) {
                    customerDAO.delete(customerOpt.get());
                    request.getSession().setAttribute("message", "Customer deleted successfully!");
                } else {
                    request.getSession().setAttribute("error", "Customer not found");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid customer ID");
            }
        }

        response.sendRedirect(request.getContextPath() + "/customers");
    }

    /**
     * Get next available customer ID
     */
    private int getNextCustomerId() {
        List<Customer> customers = customerDAO.getAll();
        if (customers == null || customers.isEmpty()) {
            return 1;
        }

        int maxId = 0;
        for (Customer c : customers) {
            if (c.getID() > maxId) {
                maxId = c.getID();
            }
        }
        return maxId + 1;
    }
}