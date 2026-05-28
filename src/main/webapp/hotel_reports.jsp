<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.hotel.model.Customer"%>
<%
    // Session Check - ඇඩ්මින් කෙනෙක්ද බලනවා
    Customer user = (Customer) session.getAttribute("loggedUser");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Servlet එකෙන් එවපු ඩේටා මැප් එක ලබා ගැනීම
    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("reportStats");
    
    // යම් හෙයකින් ඇඩ්මින් කෙලින්ම URL එක ගහලා ආවොත් (stats null නම්) සර්ව්ලට් එකට හරවනවා
    if (stats == null) {
        response.sendRedirect("HotelReportServlet");
        return;
    }
    
    // දත්ත ටික variables වලට වෙන් කර ගැනීම
    double revenue = stats.get("total_revenue") != null ? (Double) stats.get("total_revenue") : 0.0;
    int totalRooms = stats.get("total_rooms") != null ? (Integer) stats.get("total_rooms") : 0;
    int bookedRooms = stats.get("booked_rooms") != null ? (Integer) stats.get("booked_rooms") : 0;
    int availRooms = stats.get("available_rooms") != null ? (Integer) stats.get("available_rooms") : 0;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Hotel Reports</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f4f6f9; }
            .navbar-custom { background-color: #111; border-bottom: 3px solid #00c851; }
            .admin-brand { color: #00c851 !important; font-weight: 600; letter-spacing: 2px; }
            .stat-card { border-radius: 15px; border: none; color: white; transition: 0.3s; }
            .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
            .bg-revenue { background: linear-gradient(135deg, #00b09b, #96c93d); }
            .bg-rooms { background: linear-gradient(135deg, #4e54c8, #8f94fb); }
            .bg-booked { background: linear-gradient(135deg, #ff416c, #ff4b2b); }
            .bg-avail { background: linear-gradient(135deg, #f12711, #f5af19); }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand admin-brand" href="admin_dashboard.jsp">GRAND HORIZON - REPORTS</a>
                <a href="admin_dashboard.jsp" class="btn btn-sm btn-outline-light">Back to Dashboard</a>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="fw-bold text-dark mb-2 text-center">Hotel Real-Time Analytics</h2>
            <p class="text-muted text-center mb-5">හොටෙල් එකේ දැනට පවතින සජීවී ආදායම් සහ කාමර තොරතුරු වාර්තාව</p>

            <div class="row">
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="card stat-card bg-revenue p-4 shadow">
                        <h6 class="text-white-50 text-uppercase fw-bold fs-6">Total Revenue</h6>
                        <h2 class="fw-bold my-2">LKR <%= String.format("%,.2f", revenue) %></h2>
                        <p class="mb-0 small">මුළු උපයන ලද ආදායම</p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="card stat-card bg-rooms p-4 shadow">
                        <h6 class="text-white-50 text-uppercase fw-bold fs-6">Total Rooms</h6>
                        <h2 class="fw-bold my-2"><%= totalRooms %></h2>
                        <p class="mb-0 small">සිස්ටම් එකේ ඇති මුළු කාමර</p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="card stat-card bg-booked p-4 shadow">
                        <h6 class="text-white-50 text-uppercase fw-bold fs-6">Occupied Rooms</h6>
                        <h2 class="fw-bold my-2"><%= bookedRooms %></h2>
                        <p class="mb-0 small">දැනට බුක් කර ඇති කාමර</p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="card stat-card bg-avail p-4 shadow">
                        <h6 class="text-white-50 text-uppercase fw-bold fs-6">Available Rooms</h6>
                        <h2 class="fw-bold my-2"><%= availRooms %></h2>
                        <p class="mb-0 small">දැනට හිස්ව ඇති කාමර</p>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-5">
                <a href="admin_dashboard.jsp" class="btn btn-dark px-5 py-2 fw-bold shadow-sm">Return to Control Panel</a>
            </div>
        </div>

    </body>
</html>