package com.hotel.dao;

import com.hotel.model.Customer;
import com.hotel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO {

    // Register Method
    public boolean registerCustomer(Customer customer) {
        String sql = "INSERT INTO customers (name, email, password, role) VALUES (?, ?, ?, 'customer')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Register Error: " + e.getMessage());
            return false;
        }
    }

    // Login Method (Role එකත් සමඟ)
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
                    customer.setPassword(rs.getString("password"));
                    customer.setRole(rs.getString("role")); // Role එක ලබා ගැනීම
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.out.println("Login Error: " + e.getMessage());
        }
        return null;
    }
}