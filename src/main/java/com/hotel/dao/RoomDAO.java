package com.hotel.dao;

import com.hotel.model.Room;
import com.hotel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // ඩේටාබේස් එකේ තියෙන සියලුම කාමර ලබා දෙන මෙතඩ් එක
    public List<Room> getAllRooms() {
        List<Room> roomList = new ArrayList<>();
        String sql = "SELECT * FROM rooms";

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
                roomList.add(room);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching rooms: " + e.getMessage());
        }
        return roomList;
    }
}