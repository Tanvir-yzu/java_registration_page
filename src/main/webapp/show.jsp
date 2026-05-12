<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/app.css" />
    <script src="assets/app.js" defer></script>
</head>
<body>
<jsp:useBean id="selectedUser" class="com.example.registration.User" scope="request" />
<c:if test="${selectedUser.id == 0}">
    <c:redirect url="home.jsp" />
</c:if>

<div class="container">
    <h1>User Details</h1>

    <div class="grid">
        <div class="card">
            <h2>Profile</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <td><jsp:getProperty name='selectedUser' property='id' /></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><jsp:getProperty name='selectedUser' property='name' /></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><jsp:getProperty name='selectedUser' property='email' /></td>
                </tr>
                <tr>
                    <th>Phone</th>
                    <td><jsp:getProperty name='selectedUser' property='phone' /></td>
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
                <input type="hidden" name="id" value="<jsp:getProperty name='selectedUser' property='id' />" />

                <label for="name">Name</label>
                <input id="name" type="text" name="name" value="<jsp:getProperty name='selectedUser' property='name' />" required />

                <label for="email">Email</label>
                <input id="email" type="email" name="email" value="<jsp:getProperty name='selectedUser' property='email' />" required />

                <label for="phone">Phone</label>
                <input id="phone" type="text" name="phone" value="<jsp:getProperty name='selectedUser' property='phone' />" required />

                <label for="password">Password</label>
                <input id="password" type="password" name="password" placeholder="Leave blank to keep current password" />
                <div class="hint">If you leave password empty, it will not change.</div>

                <button class="btn update" type="submit">Update</button>
            </form>

            <form action="users" method="post" style="margin-top: 12px;">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="id" value="<jsp:getProperty name='selectedUser' property='id' />" />
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
