package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.dto.CustomerDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    @Autowired

    private CustomerRepository customerRepository;

    @Autowired
    private ModelMapper modelMapper;
//
//    public void addCustomer(CustomerModel customerModel) {
//        customerRepository.save(customerModel);
//
//    }

    //creating customer
    public CustomerModel addCustomer(CustomerDTO customerDTO){
       CustomerModel customerModel = modelMapper.map(customerDTO,CustomerModel.class);

      return customerRepository.save(customerModel);
    }

    public List<CustomerModel> readAllCustomer() {

        return customerRepository.findAll();
    }


    public boolean existsByPhone(String phone) {
        return customerRepository.existsByPhone(phone);
    }

    public boolean existsByEmail(String email) {
        return customerRepository.existsByEmail(email);
    }

    public CustomerModel updateCutomer(Long id, CustomerModel customerEntity) {

        CustomerModel customer = customerRepository.findById(id).orElse(null);
        if (customer != null) {
            customer.setName(customerEntity.getName());
            customer.setAddress(customerEntity.getEmail());
            customer.setAddress(customerEntity.getAddress());
            return customerRepository.save(customer);
        }
        return null;
    }

    public void deleteCustomer(Long id) {

        customerRepository.deleteById(id);

    }

    public List<CustomerModel> getAllCustomers() {
        return customerRepository.findAll();
    }


}
