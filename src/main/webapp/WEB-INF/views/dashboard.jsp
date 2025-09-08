<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 50px;
            background-color: #A8BBA3;
            color: #2F3E2F;
        }
        .header h1 {
            margin: 0;
        }
        .logout-btn {
            background-color: #2F3E2F;
            color: #FFF;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }
        .logout-btn:hover {
            background-color: #1a261a;
        }
        .content {
            padding: 50px;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Welcome, <c:out value="${sessionScope.loggedInUser.username}"/></h1>
    <a href="<c:url value='/logout'/>" class="logout-btn">Logout</a>
</div>

<div class="content">
    <h2 class="text-2xl font-bold mb-4">Dashboard</h2>
    <p>Use the navigation menu to access different sections like Customers, Transactions, and Reports.</p>
    <!-- You can add more dashboard widgets or links here -->
</div>

</body>
</html>
