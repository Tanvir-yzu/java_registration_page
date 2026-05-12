<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP useBean/getProperty Demo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/app.css" />
    <script src="assets/app.js" defer></script>
</head>
<body>
<div class="container">
    <h1>JavaBean Demo</h1>

    <div class="crud-section">
        <div class="crud-form">
            <h3>Update Values</h3>
            <form action="bean-demo.jsp" method="get">
                <div class="form-row">
                    <label for="value">value</label>
                    <input id="value" name="value" type="text" placeholder="Type something..." />
                </div>
                <div class="form-row">
                    <label for="counter">counter</label>
                    <input id="counter" name="counter" type="number" min="0" step="1" value="0" required inputmode="numeric" />
                </div>
                <button type="submit">Apply</button>
            </form>
            <div class="hint">
                Refresh the page: session/application keep values. Request/page reset to defaults.
            </div>
        </div>
    </div>

    <div class="grid">
        <div class="card">
            <h2>page scope</h2>
            <jsp:useBean id="pageBean" class="beans.DemoBean" scope="page">
                <jsp:setProperty name="pageBean" property="scopeName" value="page" />
                <jsp:setProperty name="pageBean" property="value" value="(default)" />
                <jsp:setProperty name="pageBean" property="counter" value="0" />
            </jsp:useBean>
            <jsp:setProperty name="pageBean" property="*" />

            <table>
                <tr><th>scopeName</th><td><jsp:getProperty name="pageBean" property="scopeName" /></td></tr>
                <tr><th>value</th><td><jsp:getProperty name="pageBean" property="value" /></td></tr>
                <tr><th>counter</th><td><jsp:getProperty name="pageBean" property="counter" /></td></tr>
            </table>
        </div>

        <div class="card">
            <h2>request scope</h2>
            <jsp:useBean id="requestBean" class="beans.DemoBean" scope="request">
                <jsp:setProperty name="requestBean" property="scopeName" value="request" />
                <jsp:setProperty name="requestBean" property="value" value="(default)" />
                <jsp:setProperty name="requestBean" property="counter" value="0" />
            </jsp:useBean>
            <jsp:setProperty name="requestBean" property="*" />

            <table>
                <tr><th>scopeName</th><td><jsp:getProperty name="requestBean" property="scopeName" /></td></tr>
                <tr><th>value</th><td><jsp:getProperty name="requestBean" property="value" /></td></tr>
                <tr><th>counter</th><td><jsp:getProperty name="requestBean" property="counter" /></td></tr>
            </table>
        </div>

        <div class="card">
            <h2>session scope</h2>
            <jsp:useBean id="sessionBean" class="beans.DemoBean" scope="session">
                <jsp:setProperty name="sessionBean" property="scopeName" value="session" />
                <jsp:setProperty name="sessionBean" property="value" value="(default)" />
                <jsp:setProperty name="sessionBean" property="counter" value="0" />
            </jsp:useBean>
            <jsp:setProperty name="sessionBean" property="*" />

            <table>
                <tr><th>scopeName</th><td><jsp:getProperty name="sessionBean" property="scopeName" /></td></tr>
                <tr><th>value</th><td><jsp:getProperty name="sessionBean" property="value" /></td></tr>
                <tr><th>counter</th><td><jsp:getProperty name="sessionBean" property="counter" /></td></tr>
            </table>
        </div>

        <div class="card">
            <h2>application scope</h2>
            <jsp:useBean id="appBean" class="beans.DemoBean" scope="application">
                <jsp:setProperty name="appBean" property="scopeName" value="application" />
                <jsp:setProperty name="appBean" property="value" value="(default)" />
                <jsp:setProperty name="appBean" property="counter" value="0" />
            </jsp:useBean>
            <jsp:setProperty name="appBean" property="*" />

            <table>
                <tr><th>scopeName</th><td><jsp:getProperty name="appBean" property="scopeName" /></td></tr>
                <tr><th>value</th><td><jsp:getProperty name="appBean" property="value" /></td></tr>
                <tr><th>counter</th><td><jsp:getProperty name="appBean" property="counter" /></td></tr>
            </table>
        </div>
    </div>

    <div class="actions">
        <a class="btn secondary" href="home.jsp">Back</a>
    </div>
</div>
</body>
</html>
