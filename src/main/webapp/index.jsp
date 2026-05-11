<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Person Search</title>
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
            max-width: 520px;
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
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #555;
        }
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: #b00020;
            font-size: 13px;
            margin: 10px 0 15px;
            text-align: center;
        }
        @media (max-width: 600px) {
            body {
                padding: 12px;
            }
            .container {
                padding: 18px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Search Person by ID</h1>

    <c:if test="${not empty error}">
        <div class="error"><c:out value="${error}" /></div>
    </c:if>

    <form action="${pageContext.request.contextPath}/query" method="post">
        <div class="form-group">
            <label for="personId">Person ID</label>
            <input id="personId" name="personId" type="number" required min="1" step="1" inputmode="numeric" />
        </div>
        <button type="submit">Search</button>
    </form>
</div>
</body>
</html>
