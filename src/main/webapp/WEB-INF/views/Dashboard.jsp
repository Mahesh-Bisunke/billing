<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="p-6">
<h1 class="text-2xl font-bold mb-4">Welcome, ${loggedInUser.username}!</h1>

<a href="/logout" class="bg-red-600 text-white px-4 py-2 rounded-lg">Logout</a>
</body>
</html>
