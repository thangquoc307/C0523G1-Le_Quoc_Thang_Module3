package repository;

import model.User;

import javax.jws.soap.SOAPBinding;
import java.sql.SQLException;
import java.util.List;

public interface IUserRepository {
    List<User> getUser();
    void editUser(int userId, String name, int age, String nation);
    void deleteUser(int userId);
    User getUserById(int userId);
}
