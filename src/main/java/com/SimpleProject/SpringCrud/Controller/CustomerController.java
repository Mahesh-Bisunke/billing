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

@RestController
@RequestMapping("/api")

public class CustomerController {

    @Autowired
    private CustomerService customerService;



    //@PostMapping("/create")

//    public String createCustomer(@RequestParam("name") String name,
//                                 @RequestParam("email") String email,
//                                 @RequestParam("phone") String phone,
//                                 @RequestParam("address") String address
//                                 //Model model
//                                 )
//    {
//
//        CustomerModel customer = new CustomerModel();
//        customer.setName(name);
//        customer.setEmail(email);
//        customer.setPhone(phone);
//        customer.setAddress(address);
//
//        customerService.addCustomer(customer);
//        //Add Succss Message
//      //  model.addAttribute("key","Customer Added Successfully");
//        //returning the addCustomer.jsp
//        return "Customer Added Successfully";
//    }



    //validating the customer

    @PostMapping("/customer/create")
    public ResponseEntity<?> createCustomer(@Valid @RequestBody CustomerDTO customerDTO,
                                            BindingResult bindingResult) {

        //  Handle field validation errors first
        if (bindingResult.hasErrors()) {
            List<String> list = new ArrayList<>();
            for (ObjectError objectError : bindingResult.getAllErrors()) {
                list.add(objectError.getDefaultMessage());
            }
            return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
        }

        // Check uniqueness of phone and email
        if (customerService.existsByPhone(customerDTO.getPhone())) {
            return new ResponseEntity<>("Phone number already used!", HttpStatus.BAD_REQUEST);
        }

        if (customerService.existsByEmail(customerDTO.getEmail())) {
            return new ResponseEntity<>("Email already used!", HttpStatus.BAD_REQUEST);
        }

        // Save the customer
        CustomerModel addedCustomer = customerService.addCustomer(customerDTO);

        Map<String, Object> response = new HashMap<>();
        response.put("message", "Customer Added Successfully");
        response.put("customer", addedCustomer);

        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }



    @GetMapping("/read")
    public String readCustomer(Model model) {
        List<CustomerModel> customers = customerService.readAllCustomer();
        model.addAttribute("customers", customers);
        return "allCustomers";
    }


    @PostMapping("/update")
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
    @ResponseBody
    public String deleteCustomer(@PathVariable long id) {
        customerService.deleteCustomer(id);
        return "Customer with id  "+id +"  Deleted";
    }


    //pdf download for customer

}
