<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.registration.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/app.css" />
    <script src="assets/app.js" defer></script>
</head>
<body>
<%
    User selectedUser = (User) request.getAttribute("selectedUser");
    if (selectedUser == null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>

<div class="container">
    <h1>User Details</h1>

    <div class="grid">
        <div class="card">
            <h2>Profile</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <td><%= selectedUser.getId() %></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><%= selectedUser.getName() %></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><%= selectedUser.getEmail() %></td>
                </tr>
                <tr>
                    <th>Phone</th>
                    <td><%= selectedUser.getPhone() %></td>
                </tr>
                <tr>
                    <th>Password</th>
                    <td>****</td>
                </tr>
            </table>
        </div>

        <div class="card">
            <h2>Update / Delete</h2>
            <form action="users" method="post">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="id" value="<%= selectedUser.getId() %>" />

                <label for="name">Name</label>
                <input id="name" type="text" name="name" value="<%= selectedUser.getName() %>" required />

                <label for="email">Email</label>
                <input id="email" type="email" name="email" value="<%= selectedUser.getEmail() %>" required />

                <label for="phone">Phone</label>
                <input id="phone" type="text" name="phone" value="<%= selectedUser.getPhone() %>" required />

                <label for="password">Password</label>
                <input id="password" type="password" name="password" placeholder="Leave blank to keep current password" />
                <div class="hint">If you leave password empty, it will not change.</div>

                <button class="btn update" type="submit">Update</button>
            </form>

            <form action="users" method="post" style="margin-top: 12px;">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="id" value="<%= selectedUser.getId() %>" />
                <button class="btn delete" type="submit">Delete</button>
            </form>
        </div>
    </div>

    <div class="actions">
        <a class="btn secondary" href="home.jsp#crud">Back</a>
    </div>
</div>
</body>
</html>
