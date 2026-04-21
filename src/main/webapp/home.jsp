<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.registration.User" %>
<%@ page import="com.example.registration.DBConnection" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .welcome {
            text-align: center;
            margin-bottom: 30px;
        }
        .user-info {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .user-info h2 {
            margin-top: 0;
            color: #4CAF50;
        }
        .user-info p {
            margin: 10px 0;
        }
        .logout {
            text-align: center;
        }
        .logout button {
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .logout button:hover {
            background-color: #da190b;
        }
        .nav {
            text-align: center;
            margin-bottom: 30px;
        }
        .nav a {
            margin: 0 10px;
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }
        .nav a:hover {
            text-decoration: underline;
        }
        .flash {
            padding: 10px 12px;
            border-radius: 6px;
            margin-bottom: 16px;
            text-align: center;
        }
        .flash.success {
            background: #e7f7ea;
            border: 1px solid #bde5c4;
            color: #1b5e20;
        }
        .flash.error {
            background: #fdecea;
            border: 1px solid #f5c6cb;
            color: #8a1c1c;
        }
        .crud-section {
            margin-top: 30px;
        }
        .crud-section h2 {
            color: #333;
            margin-bottom: 10px;
        }
        .crud-form {
            background-color: #f9f9f9;
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .crud-form .form-row {
            margin-bottom: 10px;
        }
        .crud-form label {
            display: block;
            font-weight: bold;
            margin-bottom: 4px;
        }
        .crud-form input[type="text"],
        .crud-form input[type="email"],
        .crud-form input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .crud-form button {
            padding: 10px 14px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .crud-form button:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #eee;
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background: #f5f5f5;
        }
        .btn {
            padding: 8px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
        }
        .btn.update {
            background: #1976d2;
            color: white;
        }
        .btn.delete {
            background: #f44336;
            color: white;
        }
        .btn.update:hover {
            background: #155fa8;
        }
        .btn.delete:hover {
            background: #da190b;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the Home Page</h1>

        <div class="nav">
            <a href="home.jsp">Home</a> |
            <a href="index.jsp">Register</a> |
            <a href="login.jsp">Login</a>
        </div>

        <%
            String flashSuccess = (String) session.getAttribute("flashSuccess");
            String flashError = (String) session.getAttribute("flashError");
            if (flashSuccess != null) {
                session.removeAttribute("flashSuccess");
        %>
            <div class="flash success"><%= flashSuccess %></div>
        <%
            }
            if (flashError != null) {
                session.removeAttribute("flashError");
        %>
            <div class="flash error"><%= flashError %></div>
        <%
            }

            User user = (User) session.getAttribute("user");
            if (user != null) {
        %>
        <div class="welcome">
            <h2>Hello, <%= user.getName() %>!</h2>
        </div>

        <div class="user-info">
            <h2>Your Profile</h2>
            <p><strong>Name:</strong> <%= user.getName() %></p>
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Phone:</strong> <%= user.getPhone() %></p>
        </div>

        <div class="crud-section" id="crud">
            <h2>User CRUD</h2>

            <div class="crud-form">
                <h3>Add New User</h3>
                <form action="users" method="post">
                    <input type="hidden" name="action" value="create" />
                    <div class="form-row">
                        <label for="createName">Name</label>
                        <input type="text" id="createName" name="name" required />
                    </div>
                    <div class="form-row">
                        <label for="createEmail">Email</label>
                        <input type="email" id="createEmail" name="email" required />
                    </div>
                    <div class="form-row">
                        <label for="createPassword">Password</label>
                        <input type="password" id="createPassword" name="password" required />
                    </div>
                    <div class="form-row">
                        <label for="createPhone">Phone</label>
                        <input type="text" id="createPhone" name="phone" required />
                    </div>
                    <button type="submit">Create</button>
                </form>
            </div>

            <%
                List<User> users = null;
                String usersError = null;
                try {
                    users = DBConnection.getAllUsers();
                } catch (Exception ex) {
                    usersError = ex.getMessage();
                }
            %>

            <% if (usersError != null) { %>
                <div class="flash error">Failed to load users: <%= usersError %></div>
            <% } else { %>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Password</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (User u : users) { %>
                        <%
                            String updateFormId = "updateForm" + u.getId();
                        %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td>
                                <input type="text" name="name" value="<%= u.getName() %>" form="<%= updateFormId %>" required />
                            </td>
                            <td>
                                <input type="email" name="email" value="<%= u.getEmail() %>" form="<%= updateFormId %>" required />
                            </td>
                            <td>
                                <input type="text" name="phone" value="<%= u.getPhone() %>" form="<%= updateFormId %>" required />
                            </td>
                            <td>
                                <input type="password" name="password" form="<%= updateFormId %>" placeholder="(leave blank to keep)" />
                            </td>
                            <td>
                                <form id="<%= updateFormId %>" action="users" method="post">
                                    <input type="hidden" name="action" value="update" />
                                    <input type="hidden" name="id" value="<%= u.getId() %>" />
                                    <button class="btn update" type="submit">Update</button>
                                </form>
                                <form action="users" method="post" style="margin-top: 8px;">
                                    <input type="hidden" name="action" value="delete" />
                                    <input type="hidden" name="id" value="<%= u.getId() %>" />
                                    <button class="btn delete" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>

        <div class="logout">
            <form action="logout" method="post">
                <button type="submit">Logout</button>
            </form>
        </div>

        <% } else { %>
        <div class="welcome">
            <h2>You are not logged in</h2>
            <p>Please <a href="login.jsp">login</a> to access your profile.</p>
        </div>
        <% } %>
    </div>
</body>
</html>
