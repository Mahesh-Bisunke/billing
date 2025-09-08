<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="p-6 md:p-10">
    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold text-gray-800">Products List</h1>
        <button id="openModalBtn"
                class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg shadow font-semibold transition">
            + Add Product
        </button>
    </div>

    <!-- Products Table -->
    <div class="bg-white shadow rounded-lg overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-800">
            <tr>
                <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">S. No</th>
                <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Name</th>
                <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Description</th>
                <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Price</th>
                <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Stock Quantity</th>
                <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <c:choose>
                <c:when test="${not empty products}">
                    <c:forEach var="prod" items="${products}" varStatus="status">
                        <tr class="hover:bg-gray-100 transition">
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${status.index + 1}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${prod.name}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${prod.description}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${prod.price}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${prod.stockQuantity}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                                <form action="/updateProduct/${prod.productId}" method="get" class="inline">
                                    <button type="submit"
                                            class="bg-yellow-400 hover:bg-yellow-500 text-white px-3 py-1 rounded-lg">Update
                                    </button>
                                </form>
                                <form action="/api/deleteP/${prod.productId}" method="post" class="inline">
                                    <button type="submit"
                                            class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-lg"
                                            onclick="return confirm('Are you sure you want to delete this Product?');">Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" class="text-center text-red-600 font-semibold py-4">No Products in this list</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal -->
<div id="productModal"
     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white w-full max-w-lg rounded-2xl shadow-lg p-6 relative">
        <button id="closeModalBtn"
                class="absolute top-3 right-3 text-gray-500 hover:text-gray-800 text-2xl">&times;</button>
        <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">Add Product</h2>

        <form id="productForm" class="space-y-4">
            <div>
                <label for="name" class="block text-gray-700 font-semibold">Product Name</label>
                <input type="text" id="name" name="name"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-green-300"/>
                <span id="nameError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="description" class="block text-gray-700 font-semibold">Description</label>
                <input type="text" id="description" name="description"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-green-300"/>
                <span id="descriptionError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="price" class="block text-gray-700 font-semibold">Price</label>
                <input type="number" id="price" name="price" step="0.01"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-green-300"/>
                <span id="priceError" class="text-red-500 text-sm"></span>
            </div>

            <div>
                <label for="stockQuantity" class="block text-gray-700 font-semibold">Stock Quantity</label>
                <input type="number" id="stockQuantity" name="stockQuantity"
                       class="w-full mt-1 p-2 border rounded-md focus:ring focus:ring-green-300"/>
                <span id="stockQuantityError" class="text-red-500 text-sm"></span>
            </div>

            <button type="button" id="submitBtn"
                    class="w-full py-2 px-4 bg-green-600 text-white rounded-lg font-semibold hover:bg-green-700 transition">
                Submit
            </button>
        </form>
    </div>
</div>

<!-- Toast Container -->
<div id="toast-container" class="fixed top-5 right-5 space-y-3 z-50"></div>

<script>
    $(document).ready(function () {
        $('#openModalBtn').click(() => $('#productModal').removeClass('hidden'));
        $('#closeModalBtn').click(() => {
            $('#productModal').addClass('hidden');
            $('#productForm')[0].reset();
            $('span.text-red-500').text('');
            $('input').removeClass('border-red-500');
        });

        function showToast(message, type = "success") {
            const bgColor = type === "success" ? "bg-green-50 text-green-700 border border-green-300" :
                "bg-red-50 text-red-700 border border-red-300";

            const icon = type === "success" ?
                `<svg class="w-5 h-5 text-green-600 rotate-45" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="m9 17 8 2L9 1 1 19l8-2Zm0 0V9"/>
                </svg>` :
                `<svg class="w-5 h-5 text-red-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 9v4m0 4h.01M21 12A9 9 0 1 1 3 12a9 9 0 0 1 18 0Z"/>
                </svg>`;

            const toast = $(`<div class="flex items-center w-full max-w-xs p-4 space-x-3 rounded-lg shadow ${bgColor} animate-slideIn" role="alert">
                ${icon}
                <span class="text-sm font-medium">${message}</span>
            </div>`);
            $("#toast-container").append(toast);
            setTimeout(() => toast.fadeOut("slow", () => toast.remove()), 5000);
        }

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
                success: function () {
                    showToast("Product Added Successfully", "success");
                    $('#productForm')[0].reset();
                    $('#productModal').addClass('hidden');
                    // Reload product table in dashboard main-content
                    $("#main-content").load("allProducts.jsp");
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

<style>
    @keyframes slideIn {
        0% { transform: translateX(100%); opacity: 0; }
        100% { transform: translateX(0); opacity: 1; }
    }
    .animate-slideIn { animation: slideIn 0.3s ease-out; }
</style>
