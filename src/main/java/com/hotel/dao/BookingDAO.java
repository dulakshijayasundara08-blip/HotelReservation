/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.hotel.dao;

import com.hotel.model.Booking;
import com.hotel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BookingDAO {

    public boolean addBooking(Booking booking) {
        String insertBookingSql = "INSERT INTO bookings (customer_id, room_id, check_in_date, check_out_date) VALUES (?, ?, ?, ?)";
        String updateRoomSql = "UPDATE rooms SET status = 'Booked' WHERE room_id = ?";
        
        Connection conn = null;
        PreparedStatement psBooking = null;
        PreparedStatement psRoom = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Transactions පාවිච්චි කරමු (වැඩ දෙකම එකවර සිදුවීමට)
            
            // 1. Booking එක ඇතුලත් කිරීම
            psBooking = conn.prepareStatement(insertBookingSql);
            psBooking.setInt(1, booking.getCustomerId());
            psBooking.setInt(2, booking.getRoomId());
            psBooking.setString(3, booking.getCheckInDate());
            psBooking.setString(4, booking.getCheckOutDate());
            int bookingResult = psBooking.executeUpdate();
            
            // 2. කාමරයේ තත්ත්වය (Status) 'Booked' ලෙස වෙනස් කිරීම
            psRoom = conn.prepareStatement(updateRoomSql);
            psRoom.setInt(1, booking.getRoomId());
            int roomResult = psRoom.executeUpdate();
            
            if (bookingResult > 0 && roomResult > 0) {
                conn.commit(); // වැඩ දෙකම සාර්ථක නම් පමණක් database එකට සේව් කරන්න
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            System.out.println("Booking Error: " + e.getMessage());
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            try {
                if (psBooking != null) psBooking.close();
                if (psRoom != null) psRoom.close();
                if (conn != null) conn.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
