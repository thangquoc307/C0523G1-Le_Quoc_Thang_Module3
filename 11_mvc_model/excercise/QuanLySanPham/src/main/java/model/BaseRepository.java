package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseRepository {
    private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/quan_ly_san_pham";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "050117companyCOMPANY123!";
    private BaseRepository(){}
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
}
