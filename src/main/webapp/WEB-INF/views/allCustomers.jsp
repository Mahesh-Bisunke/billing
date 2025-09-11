<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customers</title>

    <!-- jQuery & Tailwind -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- If you use Spring CSRF, these will be rendered and used by JS -->
    <c:if test="${not empty _csrf}">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
    </c:if>

    <style>
        .icon-size { width: 18px; height: 18px; display: inline-block; vertical-align: middle; }
    </style>
</head>
<body class="bg-gray-100">

<!-- Toast container -->
<div id="toast-container" class="fixed top-5 right-5 space-y-2 z-50"></div>

<div class="p-6 md:p-10" id="main-content">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold text-gray-800">Customers List</h1>
        <button id="openAddCustomerModal" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg shadow font-semibold transition">
            + Add Customer
        </button>
    </div>

    <div class="bg-white shadow rounded-lg overflow-hidden">
        <div class="overflow-y-auto max-h-[500px]">
            <table class="min-w-full divide-y divide-gray-200 table-auto">
                <thead class="bg-gray-800 sticky top-0 z-10">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">S.No</th>
                    <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Name</th>
                    <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Email</th>
                    <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Phone</th>
                    <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Address</th>
                    <th class="px-6 py-3 text-left text-xs font-bold text-white uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody id="customersBody" class="bg-white divide-y divide-gray-200">
                <c:choose>
                    <c:when test="${not empty customers}">
                        <c:forEach var="cust" items="${customers}" varStatus="status">
                            <tr data-customer-id="${cust.customerId}" class="hover:bg-gray-100 transition">
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${status.index + 1}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${cust.name}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${cust.email}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${cust.phone}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${cust.address}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                                    <!-- Update -->
                                    <button type="button"
<%--                                            class="update-customer-btn bg-yellow-400 hover:bg-yellow-500 text-white px-3 py-1 rounded-lg"--%>
                                            class="update-customer-btn bg-yellow-400 hover:bg-yellow-500 text-white px-3 py-1 rounded-lg"
                                            data-customer-id="${cust.customerId}"
                                            data-customer-name="${cust.name}"
                                            data-customer-email="${cust.email}"
                                            data-customer-phone="${cust.phone}"
                                            data-customer-address="${cust.address}">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                        </svg>
                                    </button>

                                    <!-- Delete: uses AJAX, no form needed -->
                                    <button type="button"
                                            class="delete-btn bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-lg"
                                            data-delete-url="${pageContext.request.contextPath}/api/delete/${cust.customerId}">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                        </svg>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr id="noCustomersRow">
                            <td colspan="6" class="text-center text-red-600 font-semibold py-4">No Customers Found</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Customer Modal (Add / Update) -->
<div id="customerModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white w-full max-w-md rounded-lg shadow-lg p-6 relative">
        <button id="closeCustomerModal" class="absolute top-3 right-3 text-gray-500 hover:text-gray-800 text-2xl">&times;</button>
        <h2 id="modalTitle" class="text-xl font-bold mb-4 text-center">Add Customer</h2>
        <form id="customerForm" class="space-y-4" data-update-base="${pageContext.request.contextPath}">
            <input type="hidden" id="customerId" name="customerId" value="">
            <div>
                <label for="customerName" class="block font-medium text-gray-700">Name:</label>
                <input type="text" id="customerName" name="name" class="w-full p-2 border rounded"/>
                <span id="nameError" class="text-red-500 text-sm"></span>
            </div>
            <div>
                <label for="customerEmail" class="block font-medium text-gray-700">Email:</label>
                <input type="email" id="customerEmail" name="email" class="w-full p-2 border rounded"/>
                <span id="emailError" class="text-red-500 text-sm"></span>
            </div>
            <div>
                <label for="customerPhone" class="block font-medium text-gray-700">Phone:</label>
                <input type="text" id="customerPhone" name="phone" class="w-full p-2 border rounded"/>
                <span id="phoneError" class="text-red-500 text-sm"></span>
            </div>
            <div>
                <label for="customerAddress" class="block font-medium text-gray-700">Address:</label>
                <input type="text" id="customerAddress" name="address" class="w-full p-2 border rounded"/>
                <span id="addressError" class="text-red-500 text-sm"></span>
            </div>
            <button type="button" id="submitCustomerBtn" class="w-full bg-blue-600 text-white p-2 rounded hover:bg-blue-700 transition">Submit</button>
        </form>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white w-full max-w-sm rounded-lg shadow-lg p-6 text-center relative">
        <h2 class="text-xl font-bold mb-4 text-red-600">Confirm Delete</h2>
        <p class="mb-6 text-gray-700">Are you sure you want to delete this customer?</p>
        <div class="flex justify-center gap-4">
            <button id="cancelDeleteBtn" class="bg-gray-400 hover:bg-gray-500 text-white px-4 py-2 rounded-lg">Cancel</button>
            <button id="confirmDeleteBtn" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg">Yes, Delete</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // contextPath from server
        const contextPath = '${pageContext.request.contextPath}';

        // CSRF support (optional)
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        // Toast
        function showToast(message, type = "success") {
            const colors = { success: "bg-green-600", error: "bg-red-600", info: "bg-blue-600" };
            const toast = $(`
                <div class="flex items-center w-full max-w-xs p-4 text-white ${colors[type]} rounded-lg shadow">
                    <span class="text-sm font-medium">${message}</span>
                </div>
            `);
            $("#toast-container").append(toast);
            setTimeout(() => toast.fadeOut(500, () => toast.remove()), 3000);
        }

        // ---------- Customer modal helpers ----------
        function resetCustomerForm() {
            $("#customerForm")[0].reset();
            $("#customerId").val("");
            $("span.text-red-500").text("");
            $("#modalTitle").text("Add Customer");
            $("#submitCustomerBtn").text("Submit");
        }

        function populateCustomerForm(data) {
            $("#customerId").val(data.id || "");
            $("#customerName").val(data.name || "");
            $("#customerEmail").val(data.email || "");
            $("#customerPhone").val(data.phone || "");
            $("#customerAddress").val(data.address || "");
            $("#modalTitle").text("Update Customer");
            $("#submitCustomerBtn").text("Update");
        }

        // Open add modal
        $("#openAddCustomerModal").click(function () {
            resetCustomerForm();
            $("#customerModal").removeClass("hidden");
        });

        // Open update modal
        $(document).on("click", ".update-customer-btn", function () {
            const data = {
                id: $(this).data("customer-id"),
                name: $(this).data("customer-name"),
                email: $(this).data("customer-email"),
                phone: $(this).data("customer-phone"),
                address: $(this).data("customer-address")
            };
            populateCustomerForm(data);
            $("#customerModal").removeClass("hidden");
        });

        // Close customer modal
        $("#closeCustomerModal").click(() => $("#customerModal").addClass("hidden"));
        $("#customerModal").click(function (e) { if (e.target === this) $("#customerModal").addClass("hidden"); });

        // Validation
        function validateForm(data) {
            let valid = true;
            $("span.text-red-500").text("");

            if (!data.name || data.name.trim().length < 3) {
                $("#nameError").text("Name must be at least 3 characters.");
                valid = false;
            }
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!data.email || !emailPattern.test(data.email)) {
                $("#emailError").text("Enter a valid email address.");
                valid = false;
            }
            if (!data.phone || data.phone.trim().length < 10) {
                $("#phoneError").text("Phone number must be at least 10 digits.");
                valid = false;
            }
            if (!data.address || data.address.trim().length < 5) {
                $("#addressError").text("Address must be at least 5 characters.");
                valid = false;
            }
            return valid;
        }

        // Submit (Create / Update) - uses AJAX and reloads on success to keep server data consistent
        $("#submitCustomerBtn").click(function () {
            const id = $("#customerId").val();
            const payload = {
                name: $("#customerName").val(),
                email: $("#customerEmail").val(),
                phone: $("#customerPhone").val(),
                address: $("#customerAddress").val()
            };
            if (!validateForm(payload)) return;

            let url = id ? `${contextPath}/api/update/${id}` : `${contextPath}/api/create`;
            let method = "POST";
            let successMessage = id ? "Customer updated successfully!" : "Customer added successfully!";

            $.ajax({
                url: url,
                type: method,
                contentType: "application/json",
                data: JSON.stringify(payload),
                beforeSend: function (xhr) {
                    $("#submitCustomerBtn").prop("disabled", true).text("Processing...");
                    if (csrfToken && csrfHeader) xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function () {
                    showToast(successMessage, "success");
                    $("#customerModal").addClass("hidden");
                    setTimeout(() => location.reload(), 500);
                },
                error: function () {
                    showToast("Error saving customer!", "error");
                },
                complete: function () {
                    $("#submitCustomerBtn").prop("disabled", false).text(id ? "Update" : "Submit");
                }
            });
        });

        $("#customerForm input").keypress(function (e) {
            if (e.which === 13) { e.preventDefault(); $("#submitCustomerBtn").click(); }
        });

        // ---------- Delete flow (AJAX) ----------
        let deleteUrl = null;
        let rowToDelete = null;

        $(document).on("click", ".delete-btn", function () {
            deleteUrl = $(this).data("delete-url");
            rowToDelete = $(this).closest("tr");
            $("#deleteModal").removeClass("hidden");
        });

        $("#cancelDeleteBtn").click(function () {
            deleteUrl = null;
            rowToDelete = null;
            $("#deleteModal").addClass("hidden");
        });

        $("#deleteModal").click(function (e) {
            if (e.target === this) {
                deleteUrl = null;
                rowToDelete = null;
                $(this).addClass("hidden");
            }
        });

        $("#confirmDeleteBtn").click(function () {
            if (!deleteUrl) return;
            $.ajax({
                url: deleteUrl,
                type: "POST", // change to "DELETE" if your backend expects DELETE verb
                beforeSend: function (xhr) {
                    if (csrfToken && csrfHeader) xhr.setRequestHeader(csrfHeader, csrfToken);
                    $("#confirmDeleteBtn").prop("disabled", true).text("Deleting...");
                },
                success: function () {
                    showToast("Customer deleted", "success");
                    $("#deleteModal").addClass("hidden");
                    if (rowToDelete) rowToDelete.remove();

                    // if table empty, show no-record row
                    if ($("#customersBody tr").length === 0) {
                        $("#customersBody").append('<tr id="noCustomersRow"><td colspan="6" class="text-center text-red-600 font-semibold py-4">No Customers Found</td></tr>');
                    }
                },
                error: function () {
                    showToast("Error deleting customer!", "error");
                },
                complete: function () {
                    $("#confirmDeleteBtn").prop("disabled", false).text("Yes, Delete");
                    deleteUrl = null;
                    rowToDelete = null;
                }
            });
        });

    }); // end document.ready
</script>

</body>
</html>
