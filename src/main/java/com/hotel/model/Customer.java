/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hotel.model;

public class Customer {
    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;

    // Default Constructor (හිස් කන්ස්ට්‍රක්ටර් එකක්)
    public Customer() {}

    // Constructor with parameters (දත්ත එකපාර ඇතුලත් කරන්න හදන කන්ස්ට්‍රක්ටර් එකක්)
    public Customer(String name, String email, String password, String phone) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
    }

    // Getters and Setters (දත්ත ඇතුලත් කිරීමට සහ ලබා ගැනීමට පාවිච්චි කරන මෙතඩ්ස්)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}

