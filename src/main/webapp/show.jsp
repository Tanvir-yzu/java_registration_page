<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.registration.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
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
        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 20px;
            align-items: start;
        }
        .card {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 16px;
        }
        .card h2 {
            margin: 0 0 12px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #eee;
            padding: 12px;
            text-align: left;
        }
        th {
            width: 160px;
            background: #f5f5f5;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 12px;
        }
        .btn {
            padding: 10px 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            display: inline-block;
            text-align: center;
        }
        .btn.update {
            background: #1976d2;
            color: white;
        }
        .btn.delete {
            background: #f44336;
            color: white;
        }
        .btn.secondary {
            background: #666;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .btn.update:hover {
            background: #155fa8;
        }
        .btn.delete:hover {
            background: #da190b;
        }
        .btn.secondary:hover {
            background: #555;
        }
        .actions {
            text-align: center;
            margin-top: 20px;
        }
        .hint {
            color: #555;
            font-size: 12px;
            margin-top: -8px;
            margin-bottom: 12px;
        }
        @media (max-width: 860px) {
            body {
                padding: 12px;
            }
            .container {
                padding: 18px;
            }
            .grid {
                grid-template-columns: 1fr;
            }
        }
        @media (max-width: 520px) {
            th {
                width: 120px;
            }
        }
    </style>
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
