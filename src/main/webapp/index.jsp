<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Person Search</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/app.css" />
    <script src="assets/app.js" defer></script>
</head>
<body>
<div class="container narrow">
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
