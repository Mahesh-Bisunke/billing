<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://jakarta.apache.org/taglibs/standard-1.1" prefix="fmt" %>

<form action="${action}" method="post" class="space-y-4 p-4 bg-white rounded shadow-md">
    <input type="hidden" name="id" value="${customer.id}"/>

    <div>
        <label for="name" class="block font-medium">Name</label>
        <input type="text" id="name" name="name" value="${customer.name}" required
               class="border p-2 w-full rounded"/>
        <c:if test="${not empty errors.name}">
            <span class="text-red-500 text-sm">${errors.name}</span>
        </c:if>
    </div>

    <div>
        <label for="email" class="block font-medium">Email</label>
        <input type="email" id="email" name="email" value="${customer.email}" required
               class="border p-2 w-full rounded"/>
        <c:if test="${not empty errors.email}">
            <span class="text-red-500 text-sm">${errors.email}</span>
        </c:if>
    </div>

    <div>
        <label for="phone" class="block font-medium">Phone</label>
        <input type="text" id="phone" name="phone" value="${customer.phone}" required
               class="border p-2 w-full rounded"/>
        <c:if test="${not empty errors.phone}">
            <span class="text-red-500 text-sm">${errors.phone}</span>
        </c:if>
    </div>

    <div class="flex justify-end">
        <button type="submit"
                class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
            ${buttonText}
        </button>
    </div>
</form>
