package controller;

import model.User;
import service.IUserService;
import service.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Users", value = "/users")
public class Users extends HttpServlet {
    private IUserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("vào doget controller");

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "displayAll":
                System.out.println("displayAll");
                String data = userService.displayUser(request, response);
                request.setAttribute("data", data);
                request.getRequestDispatcher("/index.jsp").forward(request,response);
                break;

            case "edit":
                System.out.println("edit");
                User user = userService.getUserById(request, response);
                System.out.println(user);
                request.setAttribute("id", user.getUserId());
                request.setAttribute("name", user.getUserName());
                request.setAttribute("age", user.getAge());
                request.setAttribute("nation", user.getNation());
                request.getRequestDispatcher("/edit.jsp").forward(request,response);
                break;
            case "delete":
                System.out.println("delete");
                userService.deleteUser(request, response);
                response.sendRedirect("/index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "edit":
                System.out.println("edit do post");
                userService.editUser(request,response);
                request.getRequestDispatcher("/index.jsp").forward(request,response);
                break;

        }
    }
}
