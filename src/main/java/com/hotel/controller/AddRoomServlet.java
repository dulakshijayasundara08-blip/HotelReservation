package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // අලුතින් එකතු කලා
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Tomcat සර්වර් එකට මේ සර්ව්ලට් එක අඳුරගන්න මේ Annotation එක අනිවාර්යයෙන්ම ඕනේ!
@WebServlet(name = "AddRoomServlet", urlPatterns = {"/AddRoomServlet"})
public class AddRoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. JSP Form එකෙන් එන ඩේටා ටික ගන්නවා
        String roomNumber = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        double price = Double.parseDouble(request.getParameter("price"));
        
        // 2. Room Model එකක් සාදා දත්ත ඇතුලත් කරනවා
        Room room = new Room();
        room.setRoomNumber(roomNumber);
        room.setRoomType(roomType);
        room.setPricePerNight(price);
        
        // 3. RoomDAO එක හරහා database එකට සේව් කරනවා
        RoomDAO roomDAO = new RoomDAO();
        boolean isSuccess = roomDAO.addRoom(room);
        
        if (isSuccess) {
            // සාර්ථක නම් message එකක් එක්ක ආපහු admin dashboard එකට
            response.sendRedirect("admin_dashboard.jsp?status=success");
        } else {
            // අසාර්ථක නම් error message එකක් ලින්ක් එකට දානවා
            response.sendRedirect("add_room.jsp?status=error");
        }
    }
}