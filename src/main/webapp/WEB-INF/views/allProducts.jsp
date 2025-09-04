<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Products</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
        }

        .content {
            padding: 15px 180px;
            margin-top: -140px;
        }

        h1 {
            text-align: center;
            color: #2F3E2F;
            margin-bottom: 30px;
        }

        table {
            width: 85%;
            margin: 0 auto 30px auto;
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

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background-color: #A8BBA3;
            color: #2F3E2F;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }

        .back-link:hover {
            background-color: #FFF0CE;
        }
    </style>
</head>
<body>
<jsp:include page="home.jsp"/>

<div class="content">
    <div style="text-align:center; margin:20px;">
        <button onclick="printProducts()" class="back-link"> Print Products</button>
    </div>

    <h1 style="text-align:center;">Products List</h1>

    <!-- Assign ID to table -->
    <table id="productsTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Stock Quantity</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="prod" items="${products}">
            <tr>
                <td>${prod.productId}</td>
                <td>${prod.name}</td>
                <td>${prod.description}</td>
                <td>${prod.price}</td>
                <td>${prod.stockQuantity}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div style="text-align:center;">
        <a href="/product" class="back-link">Back to Products Page</a>
    </div>
</div>

<script>
    function printProducts() {
        // Get ONLY the table
        var tableContent = document.getElementById("productsTable").outerHTML;

        // Get current date
        var today = new Date();
        var formattedDate = today.toLocaleString(); // e.g. 9/4/2025, 11:35:20 AM

        // Open new window for print
        var printWindow = window.open("", "", "height=700,width=900");
        printWindow.document.write("<html><head><title>Print Products</title>");
        printWindow.document.write("<style>table{width:100%;border-collapse:collapse;margin-top:15px;}th,td{border:1px solid #000;padding:8px;} h2{text-align:center;}</style>");
        printWindow.document.write("</head><body>");

        // Printed date
        printWindow.document.write("<h2>Printed Date: " + formattedDate + "</h2>");

        //Product List
        printWindow.document.write("<h1>Product List</h1>");

        // Table content
        printWindow.document.write(tableContent);

        printWindow.document.write("</body></html>");
        printWindow.document.close();
        printWindow.print();
    }
</script>

</body>
</html>
