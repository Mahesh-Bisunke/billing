package com.SimpleProject.SpringCrud.Controller;
import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.dto.CustomerDTO;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.w3c.dom.Document;

import java.awt.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api")

public class CustomerController {

    @Autowired
    private CustomerService customerService;




    //validating the customer


@PostMapping("/create")
public ResponseEntity<?> createCustomer(@Valid @RequestBody CustomerDTO customerDTO,
                                        BindingResult bindingResult) {

    // Field-specific validation errors
    if (bindingResult.hasErrors()) {
        Map<String, String> errors = new HashMap<>();
        bindingResult.getFieldErrors().forEach(fieldError -> {
            errors.put(fieldError.getField(), fieldError.getDefaultMessage());
        });
        return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
    }

    // Custom uniqueness checks
    Map<String, String> customErrors = new HashMap<>();
    if (customerService.existsByEmail(customerDTO.getEmail())) {
        customErrors.put("email", "Email already used!");
    }
    if (customerService.existsByPhone(customerDTO.getPhone())) {
        customErrors.put("phone", "Phone number already used!");
    }
    if (!customErrors.isEmpty()) {
        return new ResponseEntity<>(customErrors, HttpStatus.BAD_REQUEST);
    }

    // Save customer
    CustomerModel addedCustomer = customerService.addCustomer(customerDTO);

    Map<String, Object> response = new HashMap<>();
    response.put("message", "Customer Added Successfully");
    response.put("customer", addedCustomer);

    return new ResponseEntity<>(response, HttpStatus.CREATED);
}










    @GetMapping("/customers")
    public String getAllCustomers(Model model) {
        List<CustomerModel> customers = customerService.getAllCustomers();
        model.addAttribute("customers", customers);
        model.addAttribute("customer", new CustomerModel()); // ✅ add empty customer
        return "allCustomers";
    }


//making putmapping for update
    @PostMapping ("/update")
    @ResponseBody
    public String updateCustomer(@RequestParam Long id,
                                 @RequestParam String name,
                                 @RequestParam String email,
                                 @RequestParam String phone,
                                 @RequestParam String address) {
        CustomerModel customer = new CustomerModel();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customerService.updateCutomer(id, customer);
        return "updated successfully";
    }


    @PostMapping("/delete/{id}")

    public String deleteCustomer(@PathVariable long id) {
        customerService.deleteCustomer(id);
        return "redirect:/api/customers";
    }


    //pdf download for customer

}
