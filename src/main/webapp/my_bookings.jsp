<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hotel.model.Customer"%>
<%@page import="com.hotel.dao.BookingDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%
    // Session චෙක් කිරීම
    Customer user = (Customer) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // DAO එක හරහා යූසර්ගේ බුකින් ලිස්ට් එක ගන්නවා
    BookingDAO bookingDAO = new BookingDAO();
    List<Map<String, String>> myBookings = bookingDAO.getCustomerBookings(user.getId());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | My Bookings</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f4f6f9; }
            .navbar-custom { background-color: #1a1a1a; border-bottom: 3px solid #d4af37; }
            .hotel-brand { color: #d4af37 !important; font-weight: 600; letter-spacing: 2px; }
            .table-card { border-radius: 15px; border: none; background-color: white; }
            .btn-back { background-color: #1a1a1a; color: #d4af37; font-weight: 600; }
            .btn-back:hover { background-color: #d4af37; color: black; }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand hotel-brand" href="dashboard.jsp">GRAND HORIZON</a>
                <div class="d-flex align-items-center">
                    <span class="navbar-text text-white me-3">Hello, <%= user.getName() %>!</span>
                    <a href="logout.jsp" class="btn btn-sm btn-outline-danger">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold m-0">My Booking History</h3>
                <a href="dashboard.jsp" class="btn btn-back px-4">Back to Dashboard</a>
            </div>

            <div class="card table-card p-4 shadow-sm">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="p-3 rounded" style="background-color: #1a1a1a; color: #d4af37;">
                            <tr>
                                <th class="p-3">Booking ID</th>
                                <th>Room No</th>
                                <th>Room Type</th>
                                <th>Check-in Date</th>
                                <th>Check-out Date</th>
                                <th>Price per Night</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (myBookings != null && !myBookings.isEmpty()) {
                                    for (Map<String, String> booking : myBookings) {
                            %>
                            <tr>
                                <td class="fw-bold p-3">#GRH-00<%= booking.get("bookingId") %></td>
                                <td class="fw-bold text-primary">Room <%= booking.get("roomNumber") %></td>
                                <td><%= booking.get("roomType") %></td>
                                <td><span class="badge bg-light text-dark border p-2"><%= booking.get("checkIn") %></span></td>
                                <td><span class="badge bg-light text-dark border p-2"><%= booking.get("checkOut") %></span></td>
                                <td class="fw-bold">LKR <%= String.format("%,.2f", Double.parseDouble(booking.get("price"))) %></td>
                                <td><span class="badge bg-success p-2">Confirmed</span></td>
                            </tr>
                            <% 
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <h5>You haven't made any reservations yet.</h5>
                                    <a href="dashboard.jsp" style="color: #d4af37; text-decoration: none;" class="fw-bold">Book a room now!</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </body>
</html>