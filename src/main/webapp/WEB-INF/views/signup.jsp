<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

<div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-sm">
    <h2 class="text-2xl font-bold text-center text-gray-700 mb-6">Create Account</h2>

    <c:if test="${not empty error}">
        <div class="bg-red-100 text-red-700 px-4 py-2 rounded mb-4">
                ${error}
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="bg-green-100 text-green-700 px-4 py-2 rounded mb-4">
                ${success}
        </div>
    </c:if>

    <form action="/signup" method="post" class="space-y-4">
        <input type="text" name="username" placeholder="Username"
               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:ring-green-300"/>

        <input type="email" name="email" placeholder="Email"
               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:ring-green-300"/>

        <input type="password" name="password" placeholder="Password"
               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:ring-green-300"/>

        <button type="submit"
                class="w-full bg-green-600 text-white py-2 rounded-lg hover:bg-green-700 transition">
            Sign Up
        </button>
    </form>

    <p class="text-center text-sm mt-4">
        Already have an account? <a href="/login" class="text-blue-600 hover:underline">Login</a>
    </p>
</div>

</body>
</html>
