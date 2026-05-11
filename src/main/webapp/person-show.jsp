<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Person Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/app.css" />
    <script src="assets/app.js" defer></script>
</head>
<body>
<c:if test="${empty person}">
    <c:redirect url="index.jsp" />
</c:if>

<div class="container">
    <h1>Person Details</h1>

    <table>
        <tr>
            <th>ID</th>
            <td><c:out value="${person.id}" /></td>
        </tr>
        <tr>
            <th>Name</th>
            <td><c:out value="${person.name}" /></td>
        </tr>
        <tr>
            <th>Password</th>
            <td>****</td>
        </tr>
        <tr>
            <th>Gender</th>
            <td><c:out value="${person.gender}" /></td>
        </tr>
    </table>

    <div class="actions">
        <a class="btn secondary" href="index.jsp">Back to search</a>
    </div>
</div>
</body>
</html>
