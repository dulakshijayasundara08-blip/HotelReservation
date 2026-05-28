package com.hotel.dao;

import com.hotel.model.Room;
import com.hotel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoomDAO {

    // 1. දැනට Available සියලුම කාමර ලබාගන්නා මෙතඩ් එක
    public List<Room> getAllAvailableRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE status = 'Available'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setStatus(rs.getString("status"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching rooms: " + e.getMessage());
        }
        return rooms;
    }

    // 2. අලුතින් කාමරයක් ඩේටาබේස් එකට ඇතුලත් කිරීම
    public boolean addRoom(Room room) {
        String sql = "INSERT INTO rooms (room_number, room_type, price_per_night, status) VALUES (?, ?, ?, 'Available')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getRoomType());
            ps.setDouble(3, room.getPricePerNight());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Add Room Error: " + e.getMessage());
            return false;
        }
    }

    // 3. හොටෙල් එකේ සමස්ත වාර්තා (Reports) ලබා ගැනීම
    public Map<String, Object> getHotelReportStats() {
        Map<String, Object> stats = new HashMap<>();
        
        String sqlTotalRooms = "SELECT COUNT(*) AS total FROM rooms";
        String sqlBookedRooms = "SELECT COUNT(*) AS booked FROM rooms WHERE status = 'Booked'";
        String sqlTotalRevenue = "SELECT SUM(total_price) AS revenue FROM bookings";

        try (Connection conn = DBConnection.getConnection()) {
            
            // 1. මුළු කාමර ගණන
            try (PreparedStatement ps = conn.prepareStatement(sqlTotalRooms); 
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("total_rooms", rs.getInt("total"));
            }
            
            // 2. බුක් කරපු කාමර ගණන
            try (PreparedStatement ps = conn.prepareStatement(sqlBookedRooms); 
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("booked_rooms", rs.getInt("booked"));
            }
            
            // 3. මුළු ආදායම
            try (PreparedStatement ps = conn.prepareStatement(sqlTotalRevenue); 
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("total_revenue", rs.getDouble("revenue"));
                }
            }
            
            // හිස් කාමර ගණන ගණනය කිරීම
            int total = stats.get("total_rooms") != null ? (int) stats.get("total_rooms") : 0;
            int booked = stats.get("booked_rooms") != null ? (int) stats.get("booked_rooms") : 0;
            stats.put("available_rooms", (total - booked));

        } catch (SQLException e) {
            System.out.println("Report Stats Error: " + e.getMessage());
        }
        return stats;
    }
}