package com.hotel.controller;

import com.hotel.dao.CustomerDAO;
import com.hotel.model.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // වැරදිලා URL එක ගහලා ආවොත් ලොගින් පේජ් එකට හරවනවා
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.loginCustomer(email, password);
        
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", customer);
            
            if ("admin".equalsIgnoreCase(customer.getRole())) {
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                response.sendRedirect("RoomListServlet"); 
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}