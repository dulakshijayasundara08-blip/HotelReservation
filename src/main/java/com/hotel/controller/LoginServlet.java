package com.hotel.controller;

import com.hotel.dao.CustomerDAO;
import com.hotel.model.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 1. Form එකෙන් දත්ත ගැනීම
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // 2. CustomerDAO එක හරහා Check කිරීම
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.loginCustomer(email, password);
        
        if (customer != null) {
            // Login සාර්ථක නම් Session එකක් හදලා යූසර්ගේ Object එක දානවා
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", customer);
            
            // කෙලින්ම Dashboard එකට රීඩිරෙක්ට් කරනවා
            response.sendRedirect("dashboard.jsp");
        } else {
            // Login වැරදි නම් Alert එකක් පෙන්වනවා
            out.println("<script type='text/javascript'>");
            out.println("alert('Invalid Email or Password!');");
            out.println("window.location.href='login.jsp';");
            out.println("</script>");
        }
    }
}