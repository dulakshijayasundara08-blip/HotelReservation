<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hotel.model.Customer"%>
<%
    // Session එකෙන් ලොග් වුනු ඇඩ්මින්ගේ ඩේටා ගන්නවා
    Customer user = (Customer) session.getAttribute("loggedUser");
    
    // ඇඩ්මින් කෙනෙක් නෙවෙයි නම් කෙලින්ම ලොගින් පේජ් එකට හරවනවා
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Admin Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f4f6f9; }
            .navbar-custom { background-color: #111; border-bottom: 3px solid #00c851; }
            .admin-brand { color: #00c851 !important; font-weight: 600; letter-spacing: 2px; }
            .welcome-card { background: linear-gradient(135deg, #111, #222); color: white; border-radius: 15px; border-left: 5px solid #00c851; }
            .admin-card { border-radius: 12px; border: none; transition: 0.3s; }
            .admin-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
            .btn-admin { background-color: #00c851; color: white; font-weight: 600; text-decoration: none; }
            .btn-admin:hover { background-color: #007e33; color: white; }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand admin-brand" href="admin_dashboard.jsp">GRAND HORIZON - ADMIN PANEL</a>
                <div class="d-flex align-items-center">
                    <span class="navbar-text text-white me-3">Welcome, <%= user.getName() %> (Admin)</span>
                    <a href="logout.jsp" class="btn btn-sm btn-outline-danger">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="card welcome-card p-5 shadow-sm mb-5">
                <h2>Hotel Management Control Center</h2>
                <p class="text-white-50 mb-0">Add new rooms, manage reservations, and monitor system activities.</p>
            </div>

            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card admin-card p-4 text-center bg-white shadow-sm">
                        <h4 class="fw-bold mb-3">Add New Room</h4>
                        <p class="text-muted small">Insert fresh luxury rooms into the database with pricing and types.</p>
                        <a href="add_room.jsp" class="btn btn-admin w-100 p-2 mt-2">ADD ROOM</a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card admin-card p-4 text-center bg-white shadow-sm">
                        <h4 class="fw-bold mb-3">View All Bookings</h4>
                        <p class="text-muted small">Monitor all active and past hotel room reservations from customers.</p>
                        <a href="view_bookings.jsp" class="btn btn-dark w-100 p-2 mt-2">VIEW BOOKINGS</a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card admin-card p-4 text-center bg-white shadow-sm">
                        <h4 class="fw-bold mb-3">Hotel Reports</h4>
                        <p class="text-muted small">Check total daily/monthly revenue and room occupancy statistics.</p>
                        <a href="hotel_reports.jsp" class="btn btn-secondary w-100 p-2 mt-2">VIEW REPORTS</a>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>