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

// JSP Form එකේ action="RegisterServlet" කියන එක ලින්ක් වෙන්නේ මෙතනටයි
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 1. JSP Form එකෙන් එවපු දත්ත ටික ලබා ගැනීම (Form Input Names)
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // 2. ලබාගත් දත්ත ටික Setters හරහා Customer Model එකට ඇතුලත් කිරීම
        Customer customer = new Customer();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPassword(password);
        customer.setRole("customer"); // Default Role එක 'customer' ලෙස දමනවා
        
        // 3. CustomerDAO එක පාවිච්චි කරලා Database එකට සේව් කිරීම
        CustomerDAO customerDAO = new CustomerDAO();
        boolean isSuccess = customerDAO.registerCustomer(customer);
        
        // 4. ප්‍රතිඵලය අනුව User ට පණිවිඩයක් පෙන්වීම
        if (isSuccess) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Registration Successful!');");
            out.println("window.location.href='login.jsp';"); // රෙජිස්ටර් වුනාම කෙලින්ම ලොගින් පේජ් එකට යවමු
            out.println("</script>");
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Registration Failed. Email might already exist!');");
            out.println("window.location.href='register.jsp';");
            out.println("</script>");
        }
    }
}