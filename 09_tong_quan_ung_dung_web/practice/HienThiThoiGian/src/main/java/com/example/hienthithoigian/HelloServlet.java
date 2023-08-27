package com.example.hienthithoigian;

import java.io.*;
import java.util.Date;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "ten", value = "/check-time")
public class HelloServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter writer = response.getWriter();
        writer.println("");
        Date today = new Date();
        writer.println("<h1>" + today + "</h1>");
        writer.println("");
    }
}