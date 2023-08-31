package service;

import model.User;

import java.sql.SQLException;
import java.util.List;

public interface IUserService {
    void insertUser(User user);
    List<User> selectAllUsers();

    boolean deleteUser(int id);

    boolean updateUser(User user);
}
