<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; padding: 0; }
        h2 { text-align: center; margin-top: 30px; color: #333; }
        #productForm { max-width: 500px; margin: 40px auto; padding: 30px; background: #fff; border-radius: 10px; box-shadow: 0 8px 16px rgba(0,0,0,0.2); }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input[type="text"], input[type="number"] { width: 100%; padding: 10px; margin-bottom: 5px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; font-size: 14px; }
        input.error-input { border-color: #e74c3c; }
        .error { color: #e74c3c; font-size: 13px; margin-bottom: 10px; display: block; }
        .success { color: #2ecc71; font-size: 16px; text-align: center; margin-bottom: 20px; }
        button { width: 100%; padding: 12px; background: #3498db; color: #fff; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; transition: background 0.3s ease; }
        button:hover { background: #2980b9; }
        span.field-container { margin-bottom: 15px; display: block; }
    </style>
</head>
<body>

<h2>Add Product</h2>

<div id="successMessage" class="success"></div>

<form id="productForm">
    <span class="field-container">
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name">
        <span id="nameError" class="error"></span>
    </span>

    <span class="field-container">
        <label for="description">Description:</label>
        <input type="text" id="description" name="description">
        <span id="descriptionError" class="error"></span>
    </span>

    <span class="field-container">
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01">
        <span id="priceError" class="error"></span>
    </span>

    <span class="field-container">
        <label for="stockQuantity">Stock Quantity:</label>
        <input type="number" id="stockQuantity" name="stockQuantity">
        <span id="stockQuantityError" class="error"></span>
    </span>

    <button type="button" id="submitBtn">Submit</button>
</form>

<script>
    $(document).ready(function() {
        $('#submitBtn').click(function() {
            // Clear previous errors
            $('span.error').text('');
            $('input').removeClass('error-input');
            $('#successMessage').text('');

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
                success: function(response) {
                    $('#successMessage').text(response.message);
                    $('#productForm')[0].reset();
                },
                error: function(xhr) {
                    const errors = xhr.responseJSON;

                    if (errors && typeof errors === 'object') {
                        // Field-specific errors
                        for (const field in errors) {
                            $('#' + field + 'Error').text(errors[field]);
                            $('#' + field).addClass('error-input');
                        }
                    } else if (Array.isArray(errors)) {
                        // General errors
                        $('#successMessage').text(errors.join(', '));
                    }
                }
            });
        });
    });
</script>

</body>
</html>
