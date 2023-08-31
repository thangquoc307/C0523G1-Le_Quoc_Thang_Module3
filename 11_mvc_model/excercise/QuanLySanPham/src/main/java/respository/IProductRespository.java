package respository;

import model.Product;

import java.util.List;

public interface IProductRespository {
    List<Product> displayProduct();
    void addProduct(String name, int price);
    void editProduct(int id, String name, int price);
    void deleteProduct(int id);
    List<Product> findProduct(String keyword);
}
