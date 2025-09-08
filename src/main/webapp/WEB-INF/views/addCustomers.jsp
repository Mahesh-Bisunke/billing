<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Add Customer</title>--%>
<%--    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--    <script src="https://cdn.tailwindcss.com"></script>--%>
<%--    <style>--%>
<%--        /* Slide-in animation for toast */--%>
<%--        @keyframes slideIn {--%>
<%--            0% { transform: translateX(100%); opacity: 0; }--%>
<%--            100% { transform: translateX(0); opacity: 1; }--%>
<%--        }--%>
<%--        .animate-slideIn { animation: slideIn 0.3s ease-out; }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body class="bg-gray-100">--%>

<%--<!-- Button to open modal -->--%>
<%--<div class="text-center mt-10">--%>
<%--    <button id="openModalBtn" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition">--%>
<%--        Add Customer--%>
<%--    </button>--%>
<%--</div>--%>

<%--<!-- Modal -->--%>
<%--<div id="customerModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">--%>
<%--    <div class="bg-white w-full max-w-md rounded-lg shadow-lg p-6 relative">--%>
<%--        <button id="closeModalBtn" class="absolute top-3 right-3 text-gray-500 hover:text-gray-800">&times;</button>--%>
<%--        <h2 class="text-xl font-bold mb-4 text-center">Add Customer</h2>--%>
<%--        <form id="customerForm" class="space-y-4">--%>
<%--            <div>--%>
<%--                <label for="name" class="block font-medium text-gray-700">Name:</label>--%>
<%--                <input type="text" id="name" name="name" class="w-full p-2 border rounded" />--%>
<%--                <span id="nameError" class="text-red-500 text-sm"></span>--%>
<%--            </div>--%>

<%--            <div>--%>
<%--                <label for="email" class="block font-medium text-gray-700">Email:</label>--%>
<%--                <input type="email" id="email" name="email" class="w-full p-2 border rounded" />--%>
<%--                <span id="emailError" class="text-red-500 text-sm"></span>--%>
<%--            </div>--%>

<%--            <div>--%>
<%--                <label for="phone" class="block font-medium text-gray-700">Phone:</label>--%>
<%--                <input type="text" id="phone" name="phone" class="w-full p-2 border rounded" />--%>
<%--                <span id="phoneError" class="text-red-500 text-sm"></span>--%>
<%--            </div>--%>

<%--            <div>--%>
<%--                <label for="address" class="block font-medium text-gray-700">Address:</label>--%>
<%--                <input type="text" id="address" name="address" class="w-full p-2 border rounded" />--%>
<%--                <span id="addressError" class="text-red-500 text-sm"></span>--%>
<%--            </div>--%>

<%--            <button type="button" id="submitBtn" class="w-full bg-blue-600 text-white p-2 rounded hover:bg-blue-700 transition">--%>
<%--                Submit--%>
<%--            </button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<!-- Toast Container -->--%>
<%--<div id="toast-container" class="fixed top-5 right-5 z-50 flex flex-col space-y-2"></div>--%>

<%--<script>--%>
<%--    $(document).ready(function() {--%>

<%--        // Open modal--%>
<%--        $('#openModalBtn').click(function() {--%>
<%--            $('#customerModal').removeClass('hidden');--%>
<%--        });--%>

<%--        // Close modal--%>
<%--        $('#closeModalBtn').click(function() {--%>
<%--            $('#customerModal').addClass('hidden');--%>
<%--            $('#customerForm')[0].reset();--%>
<%--            $('span').text('');--%>
<%--        });--%>

<%--        // Toast function--%>
<%--        function showToast(message) {--%>
<%--            const toast = $(`--%>
<%--            <div class="flex items-center w-full max-w-xs p-4 space-x-4 text-gray-500 bg-white divide-x divide-gray-200 rounded-lg shadow-sm animate-slideIn" role="alert">--%>
<%--                <svg class="w-5 h-5 text-green-600 rotate-45" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">--%>
<%--                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m9 17 8 2L9 1 1 19l8-2Zm0 0V9"/>--%>
<%--                </svg>--%>
<%--                <div class="ps-4 text-sm font-normal">${message}</div>--%>
<%--            </div>--%>
<%--        `);--%>
<%--            $('#toast-container').append(toast);--%>
<%--            setTimeout(() => {--%>
<%--                toast.fadeOut(500, function(){ $(this).remove(); });--%>
<%--            }, 5000);--%>
<%--        }--%>

<%--        // Submit form--%>
<%--        $('#submitBtn').click(function() {--%>
<%--            $('span').text(''); // clear previous errors--%>

<%--            const customerData = {--%>
<%--                name: $('#name').val(),--%>
<%--                email: $('#email').val(),--%>
<%--                phone: $('#phone').val(),--%>
<%--                address: $('#address').val()--%>
<%--            };--%>

<%--            $.ajax({--%>
<%--                url: '/api/create',--%>
<%--                type: 'POST',--%>
<%--                contentType: 'application/json',--%>
<%--                data: JSON.stringify(customerData),--%>
<%--                success: function(response) {--%>
<%--                    $('#customerForm')[0].reset();--%>
<%--                    $('#customerModal').addClass('hidden');--%>
<%--                    showToast("Customer Added Successfully");--%>
<%--                },--%>
<%--                error: function(xhr) {--%>
<%--                    const errors = xhr.responseJSON;--%>
<%--                    if (errors && typeof errors === "object") {--%>
<%--                        for (const field in errors) {--%>
<%--                            $('#' + field + 'Error').text(errors[field]);--%>
<%--                        }--%>
<%--                    } else if (Array.isArray(errors)) {--%>
<%--                        errors.forEach(err => showToast(err));--%>
<%--                    }--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>

<%--    });--%>
<%--</script>--%>

<%--</body>--%>
<%--</html>--%>

