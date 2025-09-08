<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
</head>
<body class="flex h-screen bg-gray-100">

<!-- Sidebar Navbar -->
<aside class="w-64 bg-gray-900 text-white flex flex-col">
    <!-- Logo -->
    <div class="p-4 flex items-center justify-center border-b border-gray-700">
        <h1 class="text-xl font-bold">Billing System</h1>
    </div>

    <!-- Nav Links -->
    <nav class="flex-1 px-2 py-4 space-y-2">
        <a href="/dashboard"
           class="flex items-center px-4 py-2 rounded-lg hover:bg-gray-700 transition">
            <i class='bx bx-home text-xl mr-3'></i> Dashboard
        </a>

        <a href="/api/read"
           class="flex items-center px-4 py-2 rounded-lg hover:bg-gray-700 transition">
            <i class='bx bx-user text-xl mr-3'></i> Customers
        </a>

        <a href="/products"
           class="flex items-center px-4 py-2 rounded-lg hover:bg-gray-700 transition">
            <i class='bx bx-box text-xl mr-3'></i> Products
        </a>

        <a href="/invoices"
           class="flex items-center px-4 py-2 rounded-lg hover:bg-gray-700 transition">
            <i class='bx bx-file text-xl mr-3'></i> Invoices
        </a>

        <a href="/services"
           class="flex items-center px-4 py-2 rounded-lg hover:bg-gray-700 transition">
            <i class='bx bx-cog text-xl mr-3'></i> Services
        </a>
    </nav>

    <!-- Footer / Logout -->
    <div class="p-4 border-t border-gray-700">
        <a href="/logout"
           class="flex items-center px-4 py-2 rounded-lg bg-red-600 hover:bg-red-700 transition">
            <i class='bx bx-log-out text-xl mr-3'></i> Logout
        </a>
    </div>
</aside>

<!-- Main Content -->
<main class="flex-1 p-6">
    <h2 class="text-2xl font-bold text-gray-800">Welcome,
        <c:out value="${sessionScope.loggedInUser.username}" />
    </h2>
    <p class="mt-2 text-gray-600">This is your dashboard.</p>
</main>

</body>
</html>
