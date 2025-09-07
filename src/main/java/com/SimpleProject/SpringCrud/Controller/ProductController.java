package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.ProductService;
import com.SimpleProject.SpringCrud.dto.ProductDTO;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Valid;
import jakarta.validation.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/api")

public class ProductController {

    @Autowired
    private ProductService productService;
    @Autowired
    private final Validator validator; // inject Spring Validator

    public ProductController(ProductService productService, Validator validator) {
        this.productService = productService;
        this.validator = validator;
    }

    @PostMapping("/product/create")
    public ResponseEntity<?> createProduct(@RequestBody @Valid ProductDTO productDTO) {

        // Manual validation
        Set<ConstraintViolation<ProductDTO>> violations = validator.validate(productDTO);

        if (!violations.isEmpty()) {
            Map<String, String> errors = new HashMap<>();
            for (ConstraintViolation<ProductDTO> violation : violations) {
                String field = violation.getPropertyPath().toString();
                errors.put(field, violation.getMessage());
            }
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }

        // Save product
        ProductModel addedProduct = productService.addProduct(productDTO);

        Map<String, Object> response = new HashMap<>();
        response.put("message", "Product Added Successfully");
        response.put("product", addedProduct);

        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }





    @GetMapping("readP")
    public String readProduct(Model model) {
        List<ProductModel> products = productService.readAllProduct();
        model.addAttribute("products", products);
        return "allProducts";
    }


    @PostMapping("/updateP")
    @ResponseBody
    public String updateProductFromForm(
            @RequestParam("id") Long id,
            @RequestParam("name") String name,
            @RequestParam("description") String description,
            @RequestParam("price") double price,
            @RequestParam("stockQuantity") int stockQuantity) {

        ProductModel product = new ProductModel();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);

        productService.updateProduct(id, product);

        return "updated successfully";
    }

    @PostMapping("/deleteP/{id}")
    @ResponseBody
    public String deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return "Product with id  "+id +"  Deleted";
    }
}
