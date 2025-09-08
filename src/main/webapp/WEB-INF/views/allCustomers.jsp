<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Page Header -->
<div class="flex justify-between items-center mb-6">
    <h1 class="text-2xl font-bold text-gray-800">Customers List</h1>
    <button id="openCustomerModal"
            class="bg-blue-600 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-700 transition">
        + Add Customer
    </button>
</div>

<!-- Customers Table -->
<div class="bg-white shadow rounded-lg overflow-hidden">
    <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-800 text-white">
        <tr>
            <th class="px-6 py-3 text-left text-sm font-semibold">S. No</th>
            <th class="px-6 py-3 text-left text-sm font-semibold">Name</th>
            <th class="px-6 py-3 text-left text-sm font-semibold">Email</th>
            <th class="px-6 py-3 text-left text-sm font-semibold">Phone</th>
            <th class="px-6 py-3 text-left text-sm font-semibold">Address</th>
            <th class="px-6 py-3 text-left text-sm font-semibold">Actions</th>
        </tr>
        </thead>
        <tbody class="divide-y divide-gray-200">
        <c:choose>
            <c:when test="${not empty customers}">
                <c:forEach var="cust" items="${customers}" varStatus="status">
                    <tr class="hover:bg-gray-50">
                        <td class="px-6 py-4">${status.index + 1}</td>
                        <td class="px-6 py-4">${cust.name}</td>
                        <td class="px-6 py-4">${cust.email}</td>
                        <td class="px-6 py-4">${cust.phone}</td>
                        <td class="px-6 py-4">${cust.address}</td>
                        <td class="px-6 py-4 flex space-x-2">
                            <form action="/updateCustomer/${cust.customerId}" method="get">
                                <button type="submit"
                                        class="px-3 py-1 bg-yellow-500 text-white text-sm rounded hover:bg-yellow-600">
                                    Update
                                </button>
                            </form>
                            <form action="/api/delete/${cust.customerId}" method="post">
                                <button type="submit"
                                        onclick="return confirm('Delete this customer?');"
                                        class="px-3 py-1 bg-red-600 text-white text-sm rounded hover:bg-red-700">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6" class="text-center text-red-600 font-semibold py-6">
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
        <button id="closeCustomerModal" class="absolute top-3 right-3 text-gray-500 hover:text-gray-800 text-2xl">&times;</button>
        <h2 class="text-xl font-bold mb-4 text-center">Add Customer</h2>
        <form id="customerForm" class="space-y-4">
            <div>
                <label for="customerName" class="block font-medium text-gray-700">Name:</label>
                <input type="text" id="customerName" name="name" class="w-full p-2 border rounded" />
                <span id="nameError" class="text-red-500 text-sm"></span>
            </div>
            <div>
                <label for="customerEmail" class="block font-medium text-gray-700">Email:</label>
                <input type="email" id="customerEmail" name="email" class="w-full p-2 border rounded" />
                <span id="emailError" class="text-red-500 text-sm"></span>
            </div>
            <div>
                <label for="customerPhone" class="block font-medium text-gray-700">Phone:</label>
                <input type="number" id="customerPhone" name="phone" class="w-full p-2 border rounded" />
                <span id="phoneError" class="text-red-500 text-sm"></span>
            </div>
            <div>
                <label for="customerAddress" class="block font-medium text-gray-700">Address:</label>
                <input type="text" id="customerAddress" name="address" class="w-full p-2 border rounded" />
                <span id="addressError" class="text-red-500 text-sm"></span>
            </div>
            <button type="button" id="submitCustomerBtn"
                    class="w-full bg-blue-600 text-white p-2 rounded hover:bg-blue-700 transition">
                Submit
            </button>
        </form>
    </div>
</div>
