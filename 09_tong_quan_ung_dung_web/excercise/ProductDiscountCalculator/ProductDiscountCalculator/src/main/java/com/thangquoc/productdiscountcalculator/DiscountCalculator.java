package com.thangquoc.productdiscountcalculator;
import service.service;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DiscountCalculator",value = "/discount-calculator")

public class DiscountCalculator extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        double price = Double.parseDouble(req.getParameter("price"));
        double percentage = Double.parseDouble(req.getParameter("percentage"));

        double[] result = service.calculator(price, percentage);
        double discountAmount = result[0];
        double discountPrice = result[1];


        req.setAttribute("description", req.getParameter("description"));
        req.setAttribute("price", price);
        req.setAttribute("percentage", percentage);
        req.setAttribute("discountAmount", discountAmount);
        req.setAttribute("discountPrice", discountPrice);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
        dispatcher.forward(req,resp);
    }
}
