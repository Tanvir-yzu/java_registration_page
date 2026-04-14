<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.registration.User" %>
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