<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Customers</title>
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
    <!-- Print Button -->
    <div style="text-align:center; margin:20px;">
        <button onclick="printCustomers()" class="back-link">🖨 Print Customers</button>
    </div>

    <h1>Customer List</h1>

    <!-- ✅ Only this table will be printed -->
    <div id="customerTable">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cust" items="${customers}">
                <tr>
                    <td>${cust.customerId}</td>
                    <td>${cust.name}</td>
                    <td>${cust.email}</td>
                    <td>${cust.phone}</td>
                    <td>${cust.address}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>







    <!-- Back Button -->
    <div style="text-align:center;">
        <a href="/customer" class="back-link">⬅ Back to Customer Page</a>
    </div>
</div>

<!-- Print Script -->
<script>
    function printCustomers() {
        var content = document.getElementById("customerTable").innerHTML;

        var today = new Date();
        var formattedDate = today.toLocaleString();

        var printWindow = window.open("", "", "height=700,width=900");
        printWindow.document.write("<html><head><title>Print Customers</title>");
        printWindow.document.write("<style>table{width:100%;border-collapse:collapse;}th,td{border:1px solid #000;padding:8px;} th{background-color:#A8BBA3;color:#2F3E2F;}</style>");
        printWindow.document.write("</head><body>");
        printWindow.document.write("<h2>Printed Date: " + formattedDate + "</h2>");
        printWindow.document.write("<h2 style='text-align:center;'>Customer List</h2>");
        printWindow.document.write(content);
        printWindow.document.write("</body></html>");
        printWindow.document.close();
        printWindow.print();
    }
</script>
</body>
</html>
