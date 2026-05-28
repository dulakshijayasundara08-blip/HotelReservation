package com.hotel.controller;

import com.hotel.dao.BookingDAO;
import com.hotel.model.Booking;
import com.hotel.model.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BookRoomServlet", urlPatterns = {"/BookRoomServlet"})
public class BookRoomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // වැරදිලා GET එකෙන් ආවොත් රූම් ලිස්ට් එකට හරවනවා
        response.sendRedirect("RoomListServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("loggedUser");
        
        // යූසර් ලොග් වෙලා නැත්නම් ලොගින් පේජ් එකට
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // ෆෝම් එකේ දත්ත ලබා ගැනීම
            int customerId = user.getId(); // 💡 සටහන: ඔයාගේ Customer Model එකේ id එක ගන්නා මෙතඩ් එක getId() ද කියා චෙක් කරන්න.
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String checkIn = request.getParameter("checkInDate");
            String checkOut = request.getParameter("checkOutDate");

            // Booking Model එකක් සාදා දත්ත ඇතුලත් කිරීම
            Booking booking = new Booking();
            booking.setCustomerId(customerId);
            booking.setRoomId(roomId);
            booking.setCheckInDate(checkIn);
            booking.setCheckOutDate(checkOut);

            // DAO එක හරහා ඩේටාබේස් එකට එකතු කිරීම
            BookingDAO bookingDAO = new BookingDAO();
            boolean isBooked = bookingDAO.addBooking(booking);

            if (isBooked) {
                // බුකින් එක සාර්ථක නම් නැවත රූම් ලිස්ට් එකට යනවා (එතකොට බුක් කරපු කාමරේ 'Available' නැති නිසා ලිස්ට් එකෙන් අයින් වේවි)
                response.sendRedirect("RoomListServlet?success=booked");
            } else {
                response.sendRedirect("book_room.jsp?roomId=" + roomId + "&error=failed");
            }
            
        } catch (Exception e) {
            System.out.println("Servlet Booking Error: " + e.getMessage());
            response.sendRedirect("RoomListServlet?error=exception");
        }
    }
}