package service;

import model.Product;
import respository.ProductRepository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class ProductService {
    private static ProductRepository productRepository = new ProductRepository();
    public static List<Product> displayProduct(){
        return productRepository.displayProduct();
    }
    public static void addProduct(String name, int price){

        productRepository.addProduct(name, price);
    }
    public static void editProduct(HttpServletRequest request, HttpServletResponse response){
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int price = Integer.parseInt(request.getParameter("price"));
        productRepository.editProduct(id,name,price);
    }
    public static void deleteProduct(int id){
        productRepository.deleteProduct(id);
    }
    public static List<Product> findProduct(String keyword){
        return productRepository.findProduct(keyword);
    }
}
