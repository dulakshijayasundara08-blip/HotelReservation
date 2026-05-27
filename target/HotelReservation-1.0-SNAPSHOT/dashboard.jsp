<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hotel.model.Customer"%>
<%@page import="com.hotel.model.Room"%>
<%@page import="com.hotel.dao.RoomDAO"%>
<%@page import="java.util.List"%>
<%
    // Session එකෙන් ලොග් වුනු යූසර්ගේ ඩේටා ගන්නවා
    Customer user = (Customer) session.getAttribute("loggedUser");
    
    // යූසර් ලොග් වෙලා නැත්නම් කෙලින්ම ලොගින් පේජ් එකට හරවලා යවනවා
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // RoomDAO එකෙන් කාමර ලිස්ට් එක ගන්නවා
    RoomDAO roomDAO = new RoomDAO();
    List<Room> rooms = roomDAO.getAllRooms();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f4f6f9; }
            .navbar-custom { background-color: #1a1a1a; border-bottom: 3px solid #d4af37; }
            .hotel-brand { color: #d4af37 !important; font-weight: 600; letter-spacing: 2px; }
            .welcome-card { background: linear-gradient(135deg, #1a1a1a, #333333); color: white; border-radius: 15px; border-left: 5px solid #d4af37; }
            .room-card { border-radius: 12px; transition: 0.3s; border: none; }
            .room-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
            .action-card { border-radius: 12px; border: none; transition: 0.3s; }
            .action-card:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.08); }
            .badge-available { background-color: #28a745; color: white; padding: 6px 12px; border-radius: 20px; font-size: 12px; }
            .badge-booked { background-color: #dc3545; color: white; padding: 6px 12px; border-radius: 20px; font-size: 12px; }
            .btn-book { background-color: #d4af37; color: black; font-weight: 600; border: none; }
            .btn-book:hover { background-color: #1a1a1a; color: #d4af37; }
            .btn-custom-dark { background-color: #1a1a1a; color: #d4af37; font-weight: 600; border: none; }
            .btn-custom-dark:hover { background-color: #d4af37; color: black; }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand hotel-brand" href="dashboard.jsp">GRAND HORIZON</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav align-items-center">
                        <li class="nav-item">
                            <a class="nav-link text-white me-3 fw-bold" href="my_bookings.jsp">My Bookings</a>
                        </li>
                        <li class="nav-item">
                            <span class="navbar-text text-white-50 me-3">Hello, <%= user.getName() %>!</span>
                        </li>
                        <li class="nav-item">
                            <a href="logout.jsp" class="btn btn-sm btn-outline-danger px-3">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="card welcome-card p-5 shadow-sm mb-4">
                <h2>Welcome back to Luxury, <%= user.getName() %>!</h2>
                <p class="text-white-50 mb-0">Manage your hotel room reservations easily from your custom dashboard.</p>
            </div>

            <div class="row mb-5">
                <div class="col-md-6 mb-3 mb-md-0">
                    <div class="card action-card p-4 shadow-sm bg-white">
                        <h4 class="fw-bold">View Booking History</h4>
                        <p class="text-muted small">Check your active reservations, check-in/out dates, and payment summaries.</p>
                        <a href="my_bookings.jsp" class="btn btn-custom-dark w-100 p-2 mt-2">MY BOOKINGS</a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card action-card p-4 shadow-sm bg-white">
                        <h4 class="fw-bold">Need Assistance?</h4>
                        <p class="text-muted small">Get in touch with our 24/7 front desk luxury concierge service for any custom requests.</p>
                        <button class="btn btn-outline-dark w-100 p-2 mt-2" onclick="alert('Our support hotline +94 112 345 678 is active!')">CONTACT DESK</button>
                    </div>
                </div>
            </div>

            <h3 class="mb-4 fw-bold">Available Luxury Rooms</h3>
            <div class="row">
                <%
                    if (rooms != null && !rooms.isEmpty()) {
                        for (Room room : rooms) {
                            
                            // --- CREATIVE: කාමර වර්ගය අනුව පින්තූරය වෙනස් කිරීමේ Logic එක ---
                            String roomImageUrl = "https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=600"; // Default
                            
                            if (room.getRoomType().toLowerCase().contains("deluxe")) {
                                roomImageUrl = "https://images.unsplash.com/photo-1566665797739-1674de7a421a?q=80&w=600"; // Deluxe Room
                            } else if (room.getRoomType().toLowerCase().contains("executive")) {
                                roomImageUrl = "https://images.unsplash.com/photo-1582719508461-905c673771fd?q=80&w=600"; // Executive Room
                            } else if (room.getRoomType().toLowerCase().contains("standard")) {
                                roomImageUrl = "https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=600"; // Standard Room
                            }
                %>
                <div class="col-md-4 mb-4">
                    <div class="card room-card h-100 shadow-sm">
                        
                        <img src="<%= roomImageUrl %>" class="card-img-top" style="border-top-left-radius: 12px; border-top-right-radius: 12px; height: 220px; object-fit: cover;" alt="Room Image">
                        
                        <div class="card-body d-flex flex-column">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0 fw-bold">Room No: <%= room.getRoomNumber() %></h5>
                                <span class="<%= room.getStatus().equalsIgnoreCase("Available") ? "badge-available" : "badge-booked" %>">
                                    <%= room.getStatus() %>
                                </span>
                            </div>
                            <p class="card-text text-muted mb-2"><%= room.getRoomType() %></p>
                            <h5 class="text-dark fw-bold mb-3">LKR <%= String.format("%,.2f", room.getPricePerNight()) %> <span class="fs-6 text-muted fw-normal">/ Night</span></h5>
                            
                            <% if (room.getStatus().equalsIgnoreCase("Available")) { %>
                                <form action="book_room.jsp" method="GET" class="mt-auto">
                                    <input type="hidden" name="roomId" value="<%= room.getRoomId() %>">
                                    <button type="submit" class="btn btn-book w-100 p-2">BOOK NOW</button>
                                </form>
                            <% } else { %>
                                <button class="btn btn-secondary w-100 mt-auto p-2" disabled>NOT AVAILABLE</button>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% 
                        }
                    } else {
                %>
                <div class="col-12 text-center py-5">
                    <p class="text-muted fs-5">No rooms found in the system.</p>
                </div>
                <% } %>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>