<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/app.css" />
    <script src="assets/app.js" defer></script>
</head>
<body>
    <div class="container narrow">
        <h1>User Login</h1>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="login" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <input type="submit" value="Login">
        </form>
        <div class="link">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
</body>
</html>
