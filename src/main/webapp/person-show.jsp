<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Person Details</title>
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
            max-width: 720px;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        .actions {
            text-align: center;
            margin-top: 20px;
        }
        .actions a {
            display: inline-block;
            padding: 10px 14px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .actions a:hover {
            background: #45a049;
        }
        @media (max-width: 600px) {
            body {
                padding: 12px;
            }
            .container {
                padding: 18px;
            }
            th {
                width: 120px;
            }
        }
    </style>
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
        <a href="index.jsp">Back to search</a>
    </div>
</div>
</body>
</html>
