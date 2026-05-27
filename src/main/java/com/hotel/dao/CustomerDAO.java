package com.hotel.dao;

import com.hotel.model.Customer;
import com.hotel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO {

    // පාරිභෝගිකයෙක්ව ඩේටාබේස් එකට ඇතුලත් කරන මෙතඩ් එක (Register Customer)
    public boolean registerCustomer(Customer customer) {
        String sql = "INSERT INTO customers (name, email, password, phone) VALUES (?, ?, ?, ?)";
        
        // DBConnection එකෙන් කනෙක්ෂන් එක ගන්නවා
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // ? ලකුණු තියෙන තැන් වලට Customer Object එකේ තියෙන දත්ත ආදේශ කරනවා
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword()); // සරලවම පාස්වර්ඩ් එක දානවා
            ps.setString(4, customer.getPhone());
            
            // Query එක රන් කරනවා. එක රෝ එකක් හෝ ඊට වැඩි ගණනක් අප්ඩේට් වුනොත් true ලැබෙනවා
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Registration Error: " + e.getMessage());
            return false;
        }
    }

    // User ඇතුලත් කල Email සහ Password නිවැරදිදැයි බැලීමේ මෙතඩ් එක (Login Customer)
    public Customer loginCustomer(String email, String password) {
        String sql = "SELECT * FROM customers WHERE email = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setId(rs.getInt("id"));
                    customer.setName(rs.getString("name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhone(rs.getString("phone"));
                    return customer; // ඩේටාබේස් එකේ පරිශීලකයා සිටී නම් ඔහුගේ දත්ත සහිත Object එකක් ලැබෙයි
                }
            }
        } catch (SQLException e) {
            System.out.println("Login Error: " + e.getMessage());
        }
        return null; // පරිශීලකයා නැත්නම් හෝ පාස්වර්ඩ් වැරදිනම් null ලැබෙයි
    }
}