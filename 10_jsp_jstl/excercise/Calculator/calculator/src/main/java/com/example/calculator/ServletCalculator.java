package com.example.calculator;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ServletCalculator", value = "/ServletCalculator")
public class ServletCalculator extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        double firstOperator = Double.parseDouble(request.getParameter("first-operator"));
        double secondOperator = Double.parseDouble(request.getParameter("second-operator"));
        String operator = request.getParameter("operator");
        double result = 0;
        Boolean error = false;
        switch (operator){
            case "+":
                result = firstOperator + secondOperator;
                break;
            case "-":
                result = firstOperator - secondOperator;
                break;
            case "x":
                result= firstOperator * secondOperator;
                break;
            case "/":
                if (secondOperator == 0){
                    error = true;
                } else {
                    result = firstOperator / secondOperator;
                }
        }
        if (error){
            request.setAttribute("result", "Không thể chia cho 0");
        }else {
            request.setAttribute("result", result);
        }
        request.setAttribute("operator", operator);
        request.setAttribute("first-operator", firstOperator);
        request.setAttribute("second-operator", secondOperator);
        request.getRequestDispatcher("/index.jsp").forward(request, response);

    }
}
