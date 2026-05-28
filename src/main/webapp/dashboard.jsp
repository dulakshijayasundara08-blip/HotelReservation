<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.hotel.model.Customer"%>
<%@page import="com.hotel.model.Room"%> <%-- 💡 Room Model එක Import කරගත්තා --%>
<%
    // Session Security - ලොග් වුනු කස්ටමර්ගේ ඩේටා ගන්නවා
    Customer user = (Customer) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Servlet එකෙන් එවපු රූම්ස් ලිස්ට් එක ලබා ගැනීම (List<Room> ලෙස නිවැරදි කලා)
    List<Room> roomList = (List<Room>) request.getAttribute("roomList");
    
    // කෙලින්ම පිටුවට ආවොත් සර්ව්ලට් එකට හරවනවා
    if (roomList == null) {
        response.sendRedirect("RoomListServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Customer Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
            .navbar-custom { background-color: #111; border-bottom: 3px solid #00c851; }
            .hotel-brand { color: #00c851 !important; font-weight: 600; letter-spacing: 2px; }
            .room-card { border: none; border-radius: 15px; overflow: hidden; transition: 0.3s; background: white; }
            .room-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
            .price-tag { color: #00c851; font-weight: 600; font-size: 1.25rem; }
            .btn-book { background-color: #00c851; color: white; font-weight: 600; border-radius: 8px; }
            .btn-book:hover { background-color: #007e33; color: white; }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand hotel-brand" href="RoomListServlet">GRAND HORIZON</a>
                <div class="d-flex align-items-center">
                    <span class="navbar-text text-white me-3">Welcome, <%= user.getName() %></span>
                    <a href="my_bookings.jsp" class="btn btn-sm btn-outline-light me-2">My Bookings</a>
                    <a href="logout.jsp" class="btn btn-sm btn-outline-danger">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold text-dark">Explore Our Luxury Rooms</h2>
                <p class="text-muted">Find and book the perfect room for your ultimate relaxation</p>
                
                <%-- 💡 බුකින් එක සාර්ථක වුණාම පෙන්වන Alert එකක් එකතු කලා --%>
                <% if(request.getParameter("success") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                        <strong>🎉 Booking Confirmed!</strong> Your room has been successfully reserved.
                    </div>
                <% } %>
            </div>

            <div class="row">
                <%
                    if (roomList.isEmpty()) {
                %>
                    <div class="col-12 text-center py-5">
                        <h4 class="text-muted">No rooms available at the moment. Please check back later!</h4>
                    </div>
                <%
                    } else {
                        // 💡 Object වෙනුවට Room ලෙස මාරු කර ඩේටාබේස් දත්ත ලූප් එක ඇතුලට දැම්මා
                        for (Room r : roomList) {
                %>
                    <div class="col-md-4 mb-4">
                        <div class="card room-card shadow-sm h-100">
                            <img src="https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=600&auto=format&fit=crop" class="card-img-top" alt="Room Image" style="height: 220px; object-fit: cover;">
                            
                            <div class="card-body d-flex flex-column p-4">
                                <h4 class="card-title fw-bold text-dark"><%= r.getRoomType() %></h4> 
                                <p class="text-muted small mb-2">Room Number: <%= r.getRoomNumber() %></p>
                                <p class="card-text text-secondary flex-grow-1">Experience pure comfort with air conditioning, free Wi-Fi, and a beautiful city view.</p>
                                
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="price-tag">LKR <%= String.format("%,.2f", r.getPricePerNight()) %><span class="fs-6 text-muted fw-normal">/night</span></span>
                                    <a href="book_room.jsp?roomId=<%= r.getRoomId() %>" class="btn btn-book px-4 py-2">Book Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                <%
                        }
                    }
                %>
            </div>
        </div>

    </body>
</html>