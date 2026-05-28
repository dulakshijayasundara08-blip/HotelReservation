package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import java.io.IOException; // 💡 IOException එක හරියට Import කලා
import java.util.Map;
import jakarta.servlet.ServletException; // 💡 javax වෙනුවට jakarta ලෙස වෙනස් කලා
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HotelReportServlet", urlPatterns = {"/HotelReportServlet"})
public class HotelReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // RoomDAO එක හරහා රිපෝට් දත්ත ලබා ගැනීම
        RoomDAO roomDAO = new RoomDAO();
        Map<String, Object> reportStats = roomDAO.getHotelReportStats();
        
        // දත්ත request එකට ඇතුලත් කිරීම
        request.setAttribute("reportStats", reportStats);
        
        // hotel_reports.jsp පිටුවට Forward කිරීම
        request.getRequestDispatcher("hotel_reports.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}