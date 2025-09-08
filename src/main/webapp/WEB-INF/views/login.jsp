<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

<div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-sm">
    <h2 class="text-2xl font-bold text-center text-gray-700 mb-6">Login</h2>

    <c:if test="${not empty error}">
        <div class="bg-red-100 text-red-700 px-4 py-2 rounded mb-4">
                ${error}
        </div>
    </c:if>

    <c:if test="${param.logout eq 'true'}">
        <div class="bg-green-100 text-green-700 px-4 py-2 rounded mb-4">
            You have been logged out successfully.
        </div>
    </c:if>

    <form action="/login" method="post" class="space-y-4">
        <input type="text" name="username" placeholder="Username"
               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:ring-blue-300"/>

        <input type="password" name="password" placeholder="Password"
               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:ring-blue-300"/>

        <button type="submit"
                class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition">
            Login
        </button>
    </form>
</div>

</body>
</html>
