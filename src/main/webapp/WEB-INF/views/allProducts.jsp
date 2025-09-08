<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Products</title>
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
        .no-data {
            text-align: center;
            color: #e74c3c;
            font-weight: bold;
        }

        /* Slide-in animation for toast */
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
        <h1>Products List</h1>
        <button id="openModalBtn" class="add-button">+ Add Product</button>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Stock Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach var="prod" items="${products}">
                    <tr>
                        <td>${prod.productId}</td>
                        <td>${prod.name}</td>
                        <td>${prod.description}</td>
                        <td>${prod.price}</td>
                        <td>${prod.stockQuantity}</td>
                        <td>
                            <form action="/updateProduct/${prod.productId}" method="get" style="display:inline;">
                                <button type="submit" class="action-btn">Update</button>
                            </form>
                            <form action="/api/deleteP/${prod.productId}" method="post" style="display:inline;">
                                <button type="submit" class="action-btn"
                                        onclick="return confirm('Are you sure you want to delete this Product?');">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6" class="no-data">No Products in this list</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div id="productModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white w-full max-w-md rounded-2xl shadow-lg p-6 relative">
        <button id="closeModalBtn" class="absolute top-3 right-3 text-gray-500 hover:text-gray-800">&times;</button>
        <h2 class="text-xl font-bold mb-4 text-center">Add Product</h2>

        <form id="productForm" class="space-y-5">
            <div>
                <label for="name" class="block text-gray-700 font-semibold">Product Name</label>
                <input type="text" id="name" name="name"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-blue-300" />
                <span id="nameError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="description" class="block text-gray-700 font-semibold">Description</label>
                <input type="text" id="description" name="description"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-blue-300" />
                <span id="descriptionError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="price" class="block text-gray-700 font-semibold">Price</label>
                <input type="number" id="price" name="price" step="0.01"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-blue-300" />
                <span id="priceError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="stockQuantity" class="block text-gray-700 font-semibold">Stock Quantity</label>
                <input type="number" id="stockQuantity" name="stockQuantity"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-blue-300" />
                <span id="stockQuantityError" class="text-red-500 text-sm"></span>
            </div>

            <button type="button" id="submitBtn"
                    class="w-full py-2 px-4 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition">
                Submit
            </button>
        </form>
    </div>
</div>

<!-- Toast Container -->
<div id="toast-container" class="fixed top-5 right-5 space-y-3 z-50"></div>

<script>
    $(document).ready(function () {
        // Open modal
        $('#openModalBtn').click(() => $('#productModal').removeClass('hidden'));

        // Close modal
        $('#closeModalBtn').click(() => {
            $('#productModal').addClass('hidden');
            $('#productForm')[0].reset();
            $('span.text-red-500').text('');
            $('input').removeClass('border-red-500');
        });

        // Toast function
        function showToast(message, type = "success") {
            const bgColor = type === "success"
                ? "bg-green-50 text-green-700 border border-green-300"
                : "bg-red-50 text-red-700 border border-red-300";

            const icon = type === "success"
                ? `<svg class="w-5 h-5 text-green-600 rotate-45" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                   <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                         d="m9 17 8 2L9 1 1 19l8-2Zm0 0V9"/>
               </svg>`
                : `<svg class="w-5 h-5 text-red-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                   <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                         d="M12 9v4m0 4h.01M21 12A9 9 0 1 1 3 12a9 9 0 0 1 18 0Z"/>
               </svg>`;

            const toast = $(`
            <div class="flex items-center w-full max-w-xs p-4 space-x-3 rounded-lg shadow ${bgColor} animate-slideIn" role="alert">
                ${icon}
                <span class="text-sm font-medium">${message}</span>
            </div>
        `);
            $("#toast-container").append(toast);
            setTimeout(() => toast.fadeOut("slow", () => toast.remove()), 5000);
        }

        // Submit form
        $('#submitBtn').click(() => {
            $('span.text-red-500').text('');
            $('input').removeClass('border-red-500');

            const productData = {
                name: $('#name').val() || null,
                description: $('#description').val() || null,
                price: $('#price').val() ? parseFloat($('#price').val()) : null,
                stockQuantity: $('#stockQuantity').val() ? parseInt($('#stockQuantity').val()) : null
            };

            $.ajax({
                url: '/api/product/create',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(productData),
                success: function (response) {
                    showToast("Product Added Successfully", "success");
                    $('#productForm')[0].reset();
                    $('#productModal').addClass('hidden');
                    location.reload(); // refresh table to show new product
                },
                error: function (xhr) {
                    const errors = xhr.responseJSON;
                    if (errors && typeof errors === 'object') {
                        if (errors.name) { $('#nameError').text(errors.name); $('#name').addClass('border-red-500'); }
                        if (errors.description) { $('#descriptionError').text(errors.description); $('#description').addClass('border-red-500'); }
                        if (errors.price) { $('#priceError').text(errors.price); $('#price').addClass('border-red-500'); }
                        if (errors.stockQuantity) { $('#stockQuantityError').text(errors.stockQuantity); $('#stockQuantity').addClass('border-red-500'); }
                    } else {
                        showToast("Something went wrong!", "error");
                    }
                }
            });
        });
    });
</script>
</body>
</html>
