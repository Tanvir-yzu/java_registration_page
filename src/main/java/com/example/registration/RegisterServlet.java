package com.example.registration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
        // Create users table if it doesn't exist
        try {
            DBConnection.createUsersTable();
        } catch (SQLException e) {
            System.out.println("Error creating users table: " + e.getMessage());
            throw new ServletException("Failed to initialize database: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");

            // Create user object
            User user = new User(0, name, email, password, phone);

            // Save user to database
            DBConnection.saveUser(user);

            // Redirect to success page
            response.sendRedirect("success.jsp");
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
            // Database connection error
            request.setAttribute("error", "Database connection failed: Please ensure MySQL is running and the database exists");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Other errors
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}