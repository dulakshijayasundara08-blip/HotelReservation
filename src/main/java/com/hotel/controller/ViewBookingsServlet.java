package com.hotel.controller;

import com.hotel.dao.BookingDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewBookingsServlet", urlPatterns = {"/ViewBookingsServlet"})
public class ViewBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        BookingDAO bookingDAO = new BookingDAO();
        // 💡 ඔයාගේ DAO එකේ තියෙන ලැයිස්තුව (List<Map<String, Object>>) ලබා ගැනීම
        List<Map<String, Object>> bookingList = bookingDAO.getAllBookingsForAdmin();
        
        request.setAttribute("bookingList", bookingList);
        request.getRequestDispatcher("view_bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}