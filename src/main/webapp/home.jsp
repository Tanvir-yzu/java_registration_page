<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.registration.User" %>
<%@ page import="com.example.registration.DBConnection" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/app.css" />
    <script src="assets/app.js" defer></script>
</head>
<body>
    <div class="container">
        <h1>Welcome to the Home Page</h1>

        <div class="nav">
            <a href="home.jsp">Home</a> |
            <a href="register.jsp">Register</a> |
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

            <%
                String q = request.getParameter("q");
                if (q == null) {
                    q = "";
                }
            %>
            <form class="search-row" action="home.jsp#crud" method="get">
                <input type="text" name="q" value="<%= q %>" placeholder="Search by id, name, email, or phone" />
                <button class="btn secondary" type="submit">Search</button>
                <a class="btn secondary" href="home.jsp#crud">Clear</a>
            </form>

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
                    users = DBConnection.searchUsers(q);
                } catch (Exception ex) {
                    usersError = ex.getMessage();
                }
            %>

            <% if (usersError != null) { %>
                <div class="flash error">Failed to load users: <%= usersError %></div>
            <% } else { %>
                <div class="table-wrap">
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
                                    <div class="actions-cell">
                                        <form id="<%= updateFormId %>" action="users" method="post">
                                            <input type="hidden" name="action" value="update" />
                                            <input type="hidden" name="id" value="<%= u.getId() %>" />
                                            <button class="btn update" type="submit">Update</button>
                                        </form>
                                        <a class="btn view" href="users?id=<%= u.getId() %>">View</a>
                                        <form action="users" method="post">
                                            <input type="hidden" name="action" value="delete" />
                                            <input type="hidden" name="id" value="<%= u.getId() %>" />
                                            <button class="btn delete" type="submit">Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
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
