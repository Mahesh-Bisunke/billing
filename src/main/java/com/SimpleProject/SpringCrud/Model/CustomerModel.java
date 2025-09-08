package com.SimpleProject.SpringCrud.Model;


import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import java.util.List;
@Entity
@Table(name = "Customer")
@Data



public class CustomerModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long customerId;

    private String name;
    @Column(unique = true)
    private String email;

    @Column(unique = true)
    private String phone;

    private String address;

    @OneToMany(mappedBy = "customer", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference("customer-invoice")
    private List<InvoiceModel> invoices;






}
