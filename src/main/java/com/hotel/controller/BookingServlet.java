package com.hotel.controller;

import com.hotel.dao.BookingDAO;
import com.hotel.model.Booking;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 1. Form එකෙන් එන දත්ත ටික ලබා ගැනීම
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");
        
        // 2. Booking Object එකක් සෑදීම
        Booking booking = new Booking(customerId, roomId, checkInDate, checkOutDate);
        
        // 3. DAO එක හරහා ඩේටාබේස් එකට දැමීම
        BookingDAO bookingDAO = new BookingDAO();
        boolean success = bookingDAO.addBooking(booking);
        
        out.println("<script type='text/javascript'>");
        if (success) {
            // බුකින් එක සාර්ථක නම් Alert එකක් දමා Dashboard එකට යවයි
            out.println("alert('Room Booked Successfully!');");
            out.println("window.location.href='dashboard.jsp';");
        } else {
            // බුකින් එක අසාර්ථක නම්
            out.println("alert('Booking Failed! Please try again.');");
            out.println("window.location.href='dashboard.jsp';");
        }
        out.println("</script>");
    }
}