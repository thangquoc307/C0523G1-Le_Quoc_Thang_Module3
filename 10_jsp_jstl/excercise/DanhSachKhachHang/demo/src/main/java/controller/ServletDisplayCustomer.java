package controller;

import model.customer;
import service.customerService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDisplayCustomer", value = "/ServletDisplayCustomer")
public class ServletDisplayCustomer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<customer> list = customerService.displayCustomer();
        request.setAttribute("list", list);
        request.getRequestDispatcher("display.jsp").forward(request,response);
    }
}
