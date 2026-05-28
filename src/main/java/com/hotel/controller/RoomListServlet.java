package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RoomListServlet", urlPatterns = {"/RoomListServlet"})
public class RoomListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        RoomDAO roomDAO = new RoomDAO();
        List<Room> roomList = roomDAO.getAllAvailableRooms(); 
        
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}