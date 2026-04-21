package com.example.registration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class UsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect("home.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User sessionUser = session == null ? null : (User) session.getAttribute("user");
        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            setFlashError(session, "Missing action");
            response.sendRedirect("home.jsp");
            return;
        }

        try {
            switch (action) {
                case "create":
                    handleCreate(request, session);
                    break;
                case "update":
                    handleUpdate(request, session, sessionUser);
                    break;
                case "delete":
                    handleDelete(request, session, sessionUser);
                    break;
                default:
                    setFlashError(session, "Unknown action: " + action);
                    break;
            }
        } catch (SQLException e) {
            if (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate")) {
                setFlashError(session, "Email already exists. Please use another email.");
            } else {
                setFlashError(session, "Database error. Please ensure MySQL is running and the database exists.");
            }
        } catch (Exception e) {
            setFlashError(session, "Action failed: " + e.getMessage());
        }

        response.sendRedirect("home.jsp");
    }

    private static void handleCreate(HttpServletRequest request, HttpSession session) throws SQLException {
        String name = trimToNull(request.getParameter("name"));
        String email = trimToNull(request.getParameter("email"));
        String password = trimToNull(request.getParameter("password"));
        String phone = trimToNull(request.getParameter("phone"));

        if (name == null || email == null || password == null || phone == null) {
            setFlashError(session, "All fields are required to create a user.");
            return;
        }

        DBConnection.saveUser(new User(0, name, email, password, phone));
        setFlashSuccess(session, "User created successfully.");
    }

    private static void handleUpdate(HttpServletRequest request, HttpSession session, User sessionUser) throws SQLException {
        Integer id = parseIntOrNull(request.getParameter("id"));
        if (id == null) {
            setFlashError(session, "Invalid user id.");
            return;
        }

        String name = trimToNull(request.getParameter("name"));
        String email = trimToNull(request.getParameter("email"));
        String password = trimToNull(request.getParameter("password"));
        String phone = trimToNull(request.getParameter("phone"));

        if (name == null || email == null || phone == null) {
            setFlashError(session, "Name, email and phone are required to update a user.");
            return;
        }

        if (password == null) {
            User existing = DBConnection.getUserById(id);
            if (existing == null) {
                setFlashError(session, "User not found.");
                return;
            }
            password = existing.getPassword();
        }

        User updated = new User(id, name, email, password, phone);
        boolean ok = DBConnection.updateUser(updated);
        if (ok) {
            if (sessionUser.getId() == id) {
                session.setAttribute("user", updated);
            }
            setFlashSuccess(session, "User updated successfully.");
        } else {
            setFlashError(session, "Update failed.");
        }
    }

    private static void handleDelete(HttpServletRequest request, HttpSession session, User sessionUser) throws SQLException {
        Integer id = parseIntOrNull(request.getParameter("id"));
        if (id == null) {
            setFlashError(session, "Invalid user id.");
            return;
        }

        if (sessionUser.getId() == id) {
            setFlashError(session, "You cannot delete your own logged-in user.");
            return;
        }

        boolean ok = DBConnection.deleteUser(id);
        if (ok) {
            setFlashSuccess(session, "User deleted successfully.");
        } else {
            setFlashError(session, "Delete failed.");
        }
    }

    private static void setFlashSuccess(HttpSession session, String message) {
        session.setAttribute("flashSuccess", message);
        session.removeAttribute("flashError");
    }

    private static void setFlashError(HttpSession session, String message) {
        session.setAttribute("flashError", message);
        session.removeAttribute("flashSuccess");
    }

    private static Integer parseIntOrNull(String value) {
        if (value == null) {
            return null;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private static String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
