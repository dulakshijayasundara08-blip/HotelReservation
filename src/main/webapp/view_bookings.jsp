<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.hotel.model.Customer"%>
<%
    Customer user = (Customer) session.getAttribute("loggedUser");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Map List එක ලබා ගැනීම
    List<Map<String, Object>> bookings = (List<Map<String, Object>>) request.getAttribute("bookingList");
    if (bookings == null) {
        response.sendRedirect("ViewBookingsServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | View Bookings</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f4f6f9; }
            .navbar-custom { background-color: #111; border-bottom: 3px solid #00c851; }
            .admin-brand { color: #00c851 !important; font-weight: 600; letter-spacing: 2px; }
            .table-container { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
            .table th { background-color: #111; color: white; }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand admin-brand" href="admin_dashboard.jsp">GRAND HORIZON - BOOKINGS</a>
                <a href="admin_dashboard.jsp" class="btn btn-sm btn-outline-light">Back to Dashboard</a>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="fw-bold text-dark mb-4">Customer Reservations List</h2>
            
            <div class="table-container">
                <table class="table table-hover table-striped align-middle">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer Name</th>
                            <th>Room No</th>
                            <th>Room Type</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Total Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (bookings.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">No active bookings found.</td>
                            </tr>
                        <%
                            } else {
                                for (Map<String, Object> b : bookings) {
                        %>
                            <tr>
                                <td>#BK-<%= b.get("booking_id") %></td>
                                <td><%= b.get("customer_name") %></td>
                                <td><span class="badge bg-dark"><%= b.get("room_number") %></span></td>
                                <td><%= b.get("room_type") %></td>
                                <td><%= b.get("check_in") %></td>
                                <td><%= b.get("check_out") %></td>
                                <td class="fw-bold text-success">LKR <%= String.format("%,.2f", (Double)b.get("total_price")) %></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>