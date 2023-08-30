package service;

import model.Product;
import respository.ProductRepository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class ProductService {
    public static List<Product> displayProduct(){
        return ProductRepository.displayProduct();
    }
    public static void addProduct(String name, int price){
        ProductRepository.addProduct(name, price);
    }
    public static void editProduct(HttpServletRequest request, HttpServletResponse response){
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int price = Integer.parseInt(request.getParameter("price"));
        ProductRepository.editProduct(id,name,price);
    }
    public static void deleteProduct(int id){
        ProductRepository.deleteProduct(id);
    }
    public static List<Product> findProduct(String keyword){
        return ProductRepository.findProduct(keyword);
    }
}
