package controller;

import model.Product;
import service.ProductService;


import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Controller", value = "/product")
public class Controller extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "displayAll":
                displayProduct(request,response);
                break;
            case "addProduct":
                response.sendRedirect("/addProduct.jsp");
                break;
            case "edit":
                editProduct(request, response);
                break;
            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                ProductService.deleteProduct(id);
                displayProduct(request,response);
                break;
            case "find":

                findProduct(request,response);
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
            case "addProduct":
                addProduct(request,response);
                break;
            case "editProductAfterEnterValue":
                ProductService.editProduct(request,response);
                displayProduct(request,response);
                break;

        }
    }

    private void displayProduct(HttpServletRequest request, HttpServletResponse response){
        String data = "";
        List<Product> list = ProductService.displayProduct();
        for (int i = 0; i < list.size(); i++){
            data += "<tr><td>" + (i + 1) + "</td>"
                    + "<td>" + list.get(i).getName() + "</td>"
                    + "<td>" + list.get(i).getPrice() + "</td>"

                    + "<td><button onclick='editProduct(" + list.get(i).getId() + ",\""
                    + list.get(i).getName() + "\"," + list.get(i).getPrice() + ")'>sửa</button></td>"
                    + "<td><button onclick='deleteProduct(" + list.get(i).getId() + ")'>Xóa</button></td></tr>";
        }
        request.setAttribute("data", data);
        try {
            request.getRequestDispatcher("/displayAll.jsp").forward(request,response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    private void addProduct(HttpServletRequest request, HttpServletResponse response){

        String name = request.getParameter("name");
        int price = Integer.parseInt(request.getParameter("price"));
        ProductService.addProduct(name, price);
        displayProduct(request,response);
    }
    private void editProduct(HttpServletRequest request, HttpServletResponse response){
        String name = request.getParameter("name");
        int id = Integer.parseInt(request.getParameter("id"));
        int price = Integer.parseInt(request.getParameter("price"));
        request.setAttribute("oldName", name);
        request.setAttribute("oldPrice", price);
        request.setAttribute("id", id);
        try {
            request.getRequestDispatcher("edit.jsp").forward(request,response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    private void findProduct(HttpServletRequest request, HttpServletResponse response){
        String keyword = request.getParameter("name");
        List<Product> list = ProductService.findProduct(keyword);
        String data = "";
        if (list.size() == 0){
            data = "<h1>Không tìm thấy kết quả trùng khớp</h1>";
        } else {
            data = "<table><tr>" +
                    "<th>STT</th>" +
                    "<th>Tên</th>" +
                    "<th>Giá</th></tr>";
            for (int i = 0; i < list.size(); i++){
                data += "<tr><td>" + (i + 1) + "</td>"
                        + "<td>" + list.get(i).getName() + "</td>"
                        + "<td>" + list.get(i).getPrice() + "</td></tr>";
            }
            data += "</table>";
        }
        request.setAttribute("data", data);
        try {
            request.getRequestDispatcher("/find.jsp").forward(request,response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
