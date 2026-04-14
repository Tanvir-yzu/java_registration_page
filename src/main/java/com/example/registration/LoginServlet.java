package com.example.registration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form parameters
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            System.out.println("Login attempt with email: " + email);

            // Get user from database
            User user = DBConnection.getUserByEmail(email);

            System.out.println("User retrieved: " + (user != null ? user.getName() : "null"));

            // Check if user exists and password matches
            if (user != null && user.getPassword().equals(password)) {
                // Create session and store user information
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                System.out.println("Login successful for user: " + user.getName());
                
                // Redirect to home page
                response.sendRedirect("home.jsp");
            } else {
                // Invalid credentials
                System.out.println("Invalid credentials for email: " + email);
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
            // Database connection error
            request.setAttribute("error", "Database connection failed: Please ensure MySQL is running and the database exists");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Other errors
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}