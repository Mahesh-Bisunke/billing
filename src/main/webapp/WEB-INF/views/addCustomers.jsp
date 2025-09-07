<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }

        #customerForm {
            max-width: 500px;
            margin: 40px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .error {
            color: #e74c3c;
            font-size: 13px;
            margin-bottom: 10px;
            display: block;
        }

        .success {
            color: #2ecc71;
            font-size: 16px;
            text-align: center;
            margin-bottom: 20px;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #3498db;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #2980b9;
        }

        span.field-container {
            margin-bottom: 15px;
            display: block;
        }
    </style>
</head>
<body>

<h2>Add Customer</h2>

<div id="successMessage" class="success"></div>

<form id="customerForm">
    <span class="field-container">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name">
        <span id="nameError" class="error"></span>
    </span>

    <span class="field-container">
        <label for="email">Email:</label>
        <input type="text" id="email" name="email" >
        <span id="emailError" class="error"></span>
    </span>

    <span class="field-container">
        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone">
        <span id="phoneError" class="error"></span>
    </span>

    <span class="field-container">
        <label for="address">Address:</label>
        <input type="text" id="address" name="address">
        <span id="addressError" class="error"></span>
    </span>

    <button type="button" id="submitBtn">Add Customer</button>
</form>

<script>
    $(document).ready(function() {
        $('#submitBtn').click(function() {
            $('span.error').text('');
            $('#successMessage').text('');

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
                success: function(response) {
                    $('#successMessage').text(response.message);
                    $('#customerForm')[0].reset();
                },
                error: function(xhr) {
                    const errors = xhr.responseJSON;

                    if (Array.isArray(errors)) {
                        errors.forEach(function(err) {
                            $('#successMessage').text(err);
                        });
                    } else {
                        for (const field in errors) {
                            $('#' + field + 'Error').text(errors[field]);
                        }
                    }
                }
            });
        });
    });
</script>

</body>
</html>
