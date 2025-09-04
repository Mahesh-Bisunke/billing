package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.ProductRepository;
import com.SimpleProject.SpringCrud.dto.ProductDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class ProductService {

    @Autowired

    private ProductRepository productRepository;

    @Autowired
    private ModelMapper modelMapper;

//    public void addProduct(ProductModel productModel) {
//        productRepository.save(productModel);
//
//    }

    //adding products
    public ProductModel addProduct(ProductDTO productDTO) {
       ProductModel productModel= modelMapper.map(productDTO, ProductModel.class);
       return  productRepository.save(productModel);
    }

    public List<ProductModel> readAllProduct() {

        return productRepository.findAll();
    }

    public ProductModel updateProduct(Long id, ProductModel customerEntity) {

        ProductModel product = productRepository.findById(id).orElse(null);
        if (product != null) {
            product.setName(customerEntity.getName());
            product.setDescription(customerEntity.getDescription());
            product.setPrice(customerEntity.getPrice());
            product.setStockQuantity(customerEntity.getStockQuantity());
            return productRepository.save(product);
        }
        return null;
    }

    public void deleteProduct(Long id) {

        productRepository.deleteById(id);

    }

    public List<ProductModel> getAllProducts() {
        return productRepository.findAll();
    }
}
