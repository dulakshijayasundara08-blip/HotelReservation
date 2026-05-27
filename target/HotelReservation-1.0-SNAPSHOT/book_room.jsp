<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hotel.model.Customer"%>
<%@page import="com.hotel.model.Room"%>
<%@page import="com.hotel.dao.RoomDAO"%>
<%@page import="java.util.List"%>
<%
    // 1. Session එකෙන් ලොග් වුනු යූසර්ව ගන්නවා
    Customer user = (Customer) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. Dashboard එකෙන් එවපු Room ID එක ගන්නවා
    String roomIdStr = request.getParameter("roomId");
    Room selectedRoom = null;

    if (roomIdStr != null) {
        int roomId = Integer.parseInt(roomIdStr);
        RoomDAO roomDAO = new RoomDAO();
        
        // ඩේටාබේස් එකේ තියෙන කාමර අතරින් යූසර් තෝරපු කාමරේ විස්තර විතරක් වෙන් කරලා ගන්නවා
        List<Room> rooms = roomDAO.getAllRooms();
        for (Room r : rooms) {
            if (r.getRoomId() == roomId) {
                selectedRoom = r;
                break;
            }
        }
    }

    // කාමරයක් හොයාගන්න බැරි වුනොත් ආපහු dashboard එකට යවනවා
    if (selectedRoom == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Book Room</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f4f6f9; }
            .navbar-custom { background-color: #1a1a1a; border-bottom: 3px solid #d4af37; }
            .hotel-brand { color: #d4af37 !important; font-weight: 600; letter-spacing: 2px; }
            .booking-card { border-radius: 15px; border: none; background-color: white; }
            .btn-confirm { background-color: #d4af37; color: black; font-weight: 600; border: none; }
            .btn-confirm:hover { background-color: #1a1a1a; color: #d4af37; }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand hotel-brand" href="dashboard.jsp">GRAND HORIZON</a>
                <span class="navbar-text text-white">Hello, <%= user.getName() %>!</span>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card booking-card p-4 shadow-sm">
                        <h3 class="mb-4 fw-bold text-center" style="color: #1a1a1a;">Confirm Your Reservation</h3>
                        <hr>
                        
                        <div class="mb-4 bg-light p-3 rounded">
                            <h5 class="fw-bold text-muted small mb-1">SELECTED ROOM</h5>
                            <h4 class="fw-bold text-dark mb-1">Room No: <%= selectedRoom.getRoomNumber() %></h4>
                            <p class="text-muted mb-2"><%= selectedRoom.getRoomType() %></p>
                            <h5 class="text-primary fw-bold mb-0">LKR <%= String.format("%,.2f", selectedRoom.getPricePerNight()) %> / Night</h5>
                        </div>

                        <form action="BookingServlet" method="POST">
                            <input type="hidden" name="roomId" value="<%= selectedRoom.getRoomId() %>">
                            <input type="hidden" name="customerId" value="<%= user.getId() %>">

                            <div class="mb-3">
                                <label class="form-label fw-bold">Check-in Date</label>
                                <input type="date" name="checkInDate" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Check-out Date</label>
                                <input type="date" name="checkOutDate" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-confirm w-100 p-2 mt-3">CONFIRM RESERVATION</button>
                            <a href="dashboard.jsp" class="btn btn-light w-100 p-2 mt-2 border">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>