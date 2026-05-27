/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hotel.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/hotel_db?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; // XAMPP වල default password එක හිස් (empty)
    
    private static Connection connection = null;

    public static Connection getConnection() {
        try {
            // connection එක null නම් හෝ close වෙලා නම් අලුතින් හදනවා
            if (connection == null || connection.isClosed()) {
                try {
                    // Modern MySQL Driver එක ලෝඩ් කිරීම
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASSWORD);
                    System.out.println("Database Connection Successful!");
                } catch (ClassNotFoundException e) {
                    System.out.println("Driver Not Found: " + e.getMessage());
                }
            }
        } catch (SQLException e) {
            System.out.println("Connection Error: " + e.getMessage());
        }
        return connection;
    }
}