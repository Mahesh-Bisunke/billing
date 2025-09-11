<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="p-6 md:p-10">
    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold text-gray-800">Products List</h1>
        <button id="openModalBtn"
                class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg shadow font-semibold transition">
            + Add Product
        </button>
    </div>

    <!-- Scrollable Products Table -->
    <div class="bg-white shadow rounded-lg overflow-hidden">
        <div class="overflow-y-auto max-h-[500px]"> <!-- ✅ Scrollable container -->
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-800 sticky top-0 z-10"> <!-- ✅ Sticky header -->
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">S.No</th>
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
                                                class="bg-yellow-400 hover:bg-yellow-500 text-white px-3 py-1 rounded-lg">
                                            Update
                                        </button>
                                    </form>
                                    <form action="/api/deleteP/${prod.productId}" method="post" class="inline">
                                        <button type="submit"
                                                class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-lg"
                                                onclick="return confirm('Are you sure you want to delete this Product?');">
                                            Delete
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
</div>
