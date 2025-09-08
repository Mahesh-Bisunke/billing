<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>All Customers</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
        }

        .content {
            padding: 15px 50px;
            margin-top: 20px;
        }

        h1 {
            text-align: center;
            color: #2F3E2F;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 14px;
            font-size: 15px;
        }

        th {
            background-color: #A8BBA3;
            color: #2F3E2F;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #EFF5D2;
        }

        tr:hover {
            background-color: #FFF0CE;
            transition: background 0.3s ease;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .add-button {
            background-color: #A8BBA3;
            color: #2F3E2F;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
        }

        .add-button:hover {
            background-color: #FFF0CE;
        }

        /* Toast animation */
        @keyframes slideIn {
            0% { transform: translateX(100%); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }
        .animate-slideIn { animation: slideIn 0.3s ease-out; }
    </style>
</head>
<body>

<jsp:include page="home.jsp"/>

<div class="content">
    <div class="header">
        <h1>Customers List</h1>
        <button id="openModalBtn" class="add-button">+ Add Customer</button>
    </div>



    <table >
        <thead>
        <tr>
            <th>S. No</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty customers}">
                <c:forEach var="cust" items="${customers}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${cust.name}</td>
                        <td>${cust.email}</td>
                        <td>${cust.phone}</td>
                        <td>${cust.address}</td>
                        <td>
                            <form action="/updateCustomer/${cust.customerId}" method="get" style="display:inline;">
                                <button type="submit">Update</button>
                            </form>
                            <form action="/api/delete/${cust.customerId}" method="post" style="display:inline;">
                                <button type="submit" onclick="return confirm('Delete this customer?');">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6" style="text-align:center; color:red; font-weight:bold;">
                        No Customers Found
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

</div>

<!-- Modal -->
<div id="customerModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white w-full max-w-md rounded-lg shadow-lg p-6 relative">
        <button id="closeModalBtn" class="absolute top-3 right-3 text-gray-500 hover:text-gray-800">&times;</button>
        <h2 class="text-xl font-bold mb-4 text-center">Add Customer</h2>
        <form id="customerForm" class="space-y-4">
            <div>
                <label for="name" class="block font-medium text-gray-700">Name:</label>
                <input type="text" id="name" name="name" class="w-full p-2 border rounded" />
                <span id="nameError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="email" class="block font-medium text-gray-700">Email:</label>
                <input type="email" id="email" name="email" class="w-full p-2 border rounded" />
                <span id="emailError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="phone" class="block font-medium text-gray-700">Phone:</label>
                <input type="number" id="phone" name="phone" class="w-full p-2 border rounded" />
                <span id="phoneError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="address" class="block font-medium text-gray-700">Address:</label>
                <input type="text" id="address" name="address" class="w-full p-2 border rounded" />
                <span id="addressError" class="text-red-500 text-sm"></span>
            </div>

            <button type="button" id="submitBtn" class="w-full bg-blue-600 text-white p-2 rounded hover:bg-blue-700 transition">
                Submit
            </button>
        </form>
    </div>
</div>

<!-- Toast Container -->
<div id="toast-container" class="fixed top-5 right-5 z-50 flex flex-col space-y-2"></div>

<script>
    $(document).ready(function() {
        // Open modal
        $('#openModalBtn').click(() => $('#customerModal').removeClass('hidden'));

        // Close modal
        $('#closeModalBtn').click(() => {
            $('#customerModal').addClass('hidden');
            $('#customerForm')[0].reset();
            $('span.text-red-500').text('');
        });

        // Toast function
        function showToast(message) {
            const toast = $(`
            <div class="flex items-center w-full max-w-xs p-4 space-x-4 text-gray-500 bg-white divide-x divide-gray-200 rounded-lg shadow-sm animate-slideIn" role="alert">
                <svg class="w-5 h-5 text-green-600 rotate-45" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m9 17 8 2L9 1 1 19l8-2Zm0 0V9"/>
                </svg>
                <div class="ps-4 text-sm font-normal">${message}</div>
            </div>
        `);
            $('#toast-container').append(toast);
            setTimeout(() => toast.fadeOut(500, () => toast.remove()), 5000);
        }

        // Submit form
        $('#submitBtn').click(() => {
            $('span.text-red-500').text('');
            const customerData = {
                name: $('#name').val(),
                email: $('#email').val(),
                phone: $('#phone').val(),
                address: $('#address').val()
            };

            $.ajax({
                url: '/api/create',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(customerData),
                success: function() {
                    $('#customerForm')[0].reset();
                    $('#customerModal').addClass('hidden');
                    showToast("Customer Added Successfully");
                    location.reload(); // refresh table to show new customer
                },
                error: function(xhr) {
                    const errors = xhr.responseJSON;
                    if (errors && typeof errors === "object") {
                        for (const field in errors) {
                            $('#' + field + 'Error').text(errors[field]);
                        }
                    } else if (Array.isArray(errors)) {
                        errors.forEach(err => showToast(err));
                    }
                }
            });
        });
    });
</script>

</body>
</html>
