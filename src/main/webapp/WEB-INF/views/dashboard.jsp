<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex min-h-screen bg-gray-100 font-sans">

<!-- Sidebar -->
<div class="w-64 bg-gray-800 text-white flex flex-col justify-between">
    <div>
        <div class="p-6 text-2xl font-bold border-b border-gray-700">Dashboard</div>
        <ul class="mt-6">
            <!-- Dashboard -->
            <li id="nav-dashboard" class="px-6 py-3 hover:bg-gray-700 cursor-pointer flex items-center space-x-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h18v18H3V3z" />
                </svg>
                <span>Dashboard</span>
            </li>
            <!-- Customers -->
            <li id="nav-customers" class="px-6 py-3 hover:bg-gray-700 cursor-pointer flex items-center space-x-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2h5" />
                    <circle cx="12" cy="7" r="4" stroke="currentColor" stroke-width="2" />
                </svg>
                <span>Customers</span>
            </li>
            <!-- Products -->
            <li id="nav-products" class="px-6 py-3 hover:bg-gray-700 cursor-pointer flex items-center space-x-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V7a2 2 0 00-2-2H6a2 2 0 00-2 2v6m16 0l-8 8-8-8" />
                </svg>
                <span>Products</span>
            </li>
            <!-- Invoices -->
            <li id="nav-invoices" class="px-6 py-3 hover:bg-gray-700 cursor-pointer flex items-center space-x-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-6h6v6m2 2H7a2 2 0 01-2-2V7a2 2 0 012-2h10a2 2 0 012 2v10a2 2 0 01-2 2z" />
                </svg>
                <span>Invoices</span>
            </li>
            <!-- Services -->
            <li id="nav-services" class="px-6 py-3 hover:bg-gray-700 cursor-pointer flex items-center space-x-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-3-3v6m2 5h4a2 2 0 002-2v-4M3 17h4a2 2 0 002-2v-4" />
                </svg>
                <span>Services</span>
            </li>
        </ul>
    </div>

    <!-- Logout -->
    <div class="p-6 border-t border-gray-700">
        <button id="logout-btn" class="w-full flex items-center justify-center px-4 py-2 bg-red-600 rounded text-white">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a2 2 0 002 2h3a2 2 0 002-2v-1m0-8V7a2 2 0 00-2-2h-3a2 2 0 00-2 2v1" />
            </svg>
            Logout
        </button>
    </div>
</div>

<!-- Main Content -->
<div class="flex-1 p-6" id="main-content">
    <div class="text-center p-10">
        <h1 class="text-4xl font-bold text-gray-800">Welcome to Dashboard</h1>
        <p class="mt-4 text-gray-600">Use the sidebar to navigate to Customers, Products, Invoices, or Services.</p>
    </div>
</div>

<!-- Toast container -->
<div id="toast-container" class="fixed top-5 right-5 space-y-3 z-50"></div>

<script>
    $(document).ready(function() {

        function loadContent(page) {
            $("#main-content").fadeOut(150, function() {
                $("#main-content").load(page, function() {
                    $("#main-content").fadeIn(150);
                    initDynamicPage();
                });
            });
        }

        function setActive(element) {
            $("ul li").removeClass("bg-gray-700");
            element.addClass("bg-gray-700");
        }

        // Sidebar click events
        $("#nav-dashboard").click(function() {
            setActive($(this));
            $("#main-content").html(`<div class="text-center p-10">
            <h1 class="text-4xl font-bold text-gray-800">Welcome to Dashboard</h1>
            <p class="mt-4 text-gray-600">Use the sidebar to navigate to Customers, Products, Invoices, or Services.</p>
        </div>`);
        });
        $("#nav-customers").click(function() { setActive($(this)); loadContent("allCustomers.jsp"); });
        $("#nav-products").click(function() { setActive($(this)); loadContent("allProducts.jsp"); });
        $("#nav-invoices").click(function() { setActive($(this)); loadContent("allInvoices.jsp"); });
        $("#nav-services").click(function() { setActive($(this)); loadContent("allServices.jsp"); });

        // Logout
        $("#logout-btn").click(function() { window.location.href = "/logout"; });

        // Initialize modal/AJAX for dynamic pages
        function initDynamicPage() {
            // Customers modal example
            $('#openCustomerModal').click(() => $('#customerModal').removeClass('hidden'));
            $('#closeCustomerModal').click(() => {
                $('#customerModal').addClass('hidden');
                $('#customerForm')[0].reset();
                $('span.text-red-500').text('');
            });
            $('#submitCustomerBtn').click(() => {
                $('span.text-red-500').text('');
                const data = {
                    name: $('#customerName').val(),
                    email: $('#customerEmail').val(),
                    phone: $('#customerPhone').val(),
                    address: $('#customerAddress').val()
                };
                $.ajax({
                    url: '/api/create',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: function() {
                        $('#customerForm')[0].reset();
                        $('#customerModal').addClass('hidden');
                        showToast("Customer Added Successfully");
                        $("#main-content").load("allCustomers.jsp", initDynamicPage);
                    },
                    error: function(xhr) {
                        const errors = xhr.responseJSON;
                        if(errors) {
                            for(const field in errors) {
                                $('#' + field + 'Error').text(errors[field]);
                            }
                        }
                    }
                });
            });

            // TODO: Add Products, Services, Invoices dynamic scripts here
        }

        function showToast(msg) {
            const toast = $(`<div class="p-2 bg-green-100 text-green-700 rounded shadow">${msg}</div>`);
            $('#toast-container').append(toast);
            setTimeout(() => toast.fadeOut(500, ()=>toast.remove()), 3000);
        }

    });
</script>

</body>
</html>
