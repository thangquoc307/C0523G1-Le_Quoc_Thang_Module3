package respository;

import model.BaseRepository;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {
    private static final String SELECT = "select * from `san_pham`";
    private static final String ADD = "insert into `san_pham`(`ten`,`gia`) values (?, ?)";
    private static final String EDIT = "update `san_pham` set `ten` = ?, `gia` = ? where (`id` = ?);";
    private static final String DEL = "delete from `san_pham` where (`id` = ?);";
    private static final String FIND = "select * from `san_pham` where `ten` like ?;";

    public static List<Product> displayProduct(){
        List<Product> list = new ArrayList<>();
        try {
            Connection connection = BaseRepository.getConnection();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(SELECT);

            while (resultSet.next()){
                int id = resultSet.getInt("id");
                String name = resultSet.getString("ten");
                int price = resultSet.getInt("gia");

                list.add(new Product(id, name, price));

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
    public static void addProduct(String name, int price){
        try {
            Connection connection = BaseRepository.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(ADD);

            preparedStatement.setString(1,name);
            preparedStatement.setInt(2, price);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void editProduct(int id, String name, int price){
        try {
            Connection connection = BaseRepository.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(EDIT);

            preparedStatement.setString(1,name);
            preparedStatement.setInt(2, price);
            preparedStatement.setInt(3, id);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void deleteProduct(int id){
        try {
            Connection connection = BaseRepository.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DEL);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static List<Product> findProduct(String keyword){
        List<Product> list = new ArrayList<>();
        try {
            Connection connection = BaseRepository.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(FIND);
            preparedStatement.setString(1,"%" + keyword + "%");

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()){
                int id = resultSet.getInt("id");
                String name = resultSet.getString("ten");
                int price = resultSet.getInt("gia");

                list.add(new Product(id, name, price));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
