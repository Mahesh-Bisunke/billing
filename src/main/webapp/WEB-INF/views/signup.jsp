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

    <!-- Error Toast -->
    <c:if test="${not empty error}">
        <div id="toast-error" class="flex items-center w-full max-w-xs p-4 mb-4 space-x-4 rtl:space-x-reverse
             text-red-600 bg-white divide-x rtl:divide-x-reverse divide-gray-200
             rounded-lg shadow-sm dark:text-red-400 dark:divide-gray-700 dark:bg-gray-800" role="alert">
            <svg class="w-5 h-5 text-red-600 dark:text-red-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M9 1l8 16H1L9 1zm0 12h0m0-4h0"/>
            </svg>
            <div class="ps-4 text-sm font-normal">${error}</div>
        </div>
    </c:if>

    <!-- Success Toast -->
    <c:if test="${not empty success}">
        <div id="toast-success" class="flex items-center w-full max-w-xs p-4 mb-4 space-x-4 rtl:space-x-reverse
             text-green-600 bg-white divide-x rtl:divide-x-reverse divide-gray-200
             rounded-lg shadow-sm dark:text-green-400 dark:divide-gray-700 dark:bg-gray-800" role="alert">
            <svg class="w-5 h-5 text-green-600 dark:text-green-500 rotate-45" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="m9 17 8 2L9 1 1 19l8-2Zm0 0V9"/>
            </svg>
            <div class="ps-4 text-sm font-normal">${success}</div>
        </div>
    </c:if>

    <!-- Signup Form -->
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
