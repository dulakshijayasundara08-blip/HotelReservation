/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hotel.dao;

import com.hotel.model.Booking;
import com.hotel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.HashMap;   
import java.util.List;      
import java.util.Map;       

public class BookingDAO {

    // 1. කාමර බුක් කරන මෙතඩ් එක
    public boolean addBooking(Booking booking) {
        String insertBookingSql = "INSERT INTO bookings (customer_id, room_id, check_in_date, check_out_date) VALUES (?, ?, ?, ?)";
        String updateRoomSql = "UPDATE rooms SET status = 'Booked' WHERE room_id = ?";
        
        Connection conn = null;
        PreparedStatement psBooking = null;
        PreparedStatement psRoom = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); 
            
            psBooking = conn.prepareStatement(insertBookingSql);
            psBooking.setInt(1, booking.getCustomerId());
            psBooking.setInt(2, booking.getRoomId());
            psBooking.setString(3, booking.getCheckInDate());
            psBooking.setString(4, booking.getCheckOutDate());
            int bookingResult = psBooking.executeUpdate();
            
            psRoom = conn.prepareStatement(updateRoomSql);
            psRoom.setInt(1, booking.getRoomId());
            int roomResult = psRoom.executeUpdate();
            
            if (bookingResult > 0 && roomResult > 0) {
                conn.commit(); 
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

    // 2. යූසර්ගේ බුකින් විස්තර ලබා ගන්නා මෙතඩ් එක
    public List<Map<String, String>> getCustomerBookings(int customerId) {
        List<Map<String, String>> bookingList = new ArrayList<>();
        String sql = "SELECT b.booking_id, r.room_number, r.room_type, b.check_in_date, b.check_out_date, r.price_per_night " +
                     "FROM bookings b JOIN rooms r ON b.room_id = r.room_id WHERE b.customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("bookingId", String.valueOf(rs.getInt("booking_id")));
                    map.put("roomNumber", rs.getString("room_number"));
                    map.put("roomType", rs.getString("room_type"));
                    map.put("checkIn", rs.getString("check_in_date"));
                    map.put("checkOut", rs.getString("check_out_date"));
                    map.put("price", String.valueOf(rs.getDouble("price_per_night")));
                    bookingList.add(map);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching customer bookings: " + e.getMessage());
        }
        return bookingList;
    } // <-- මෙතනින් getCustomerBookings මෙතඩ් එක හරියට වැහුණා!

    // 3. සියලුම බුකින්ස් ඇඩ්මින්ට පෙන්වීම සඳහා ලබා ගැනීම
    public List<Map<String, Object>> getAllBookingsForAdmin() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, c.name AS customer_name, r.room_number, r.room_type, " +
                     "b.check_in_date, b.check_out_date, (r.price_per_night * DATEDIFF(b.check_out_date, b.check_in_date)) AS total_price " +
                     "FROM bookings b " +
                     "JOIN customers c ON b.customer_id = c.id " +
                     "JOIN rooms r ON b.room_id = r.room_id " +
                     "ORDER BY b.booking_id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("booking_id", rs.getInt("booking_id"));
                map.put("customer_name", rs.getString("customer_name"));
                map.put("room_number", rs.getString("room_number"));
                map.put("room_type", rs.getString("room_type"));
                map.put("check_in", rs.getDate("check_in_date"));
                map.put("check_out", rs.getDate("check_out_date"));
                
                // ඇඩ්මින් පැනල් එකේ Total Price එක බලාගන්න ක්‍රමවත් කලා
                double totalPrice = rs.getDouble("total_price");
                if(totalPrice <= 0) { 
                    // දින ගණන 0 හෝ වැරදි නම් එක රැයක මිල පෙන්වයි
                    totalPrice = rs.getDouble("total_price"); 
                }
                map.put("total_price", totalPrice);
                
                list.add(map);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching all bookings: " + e.getMessage());
        }
        return list;
    }
}