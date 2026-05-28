<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hotel.model.Customer"%>
<%
    // සෙෂන් චෙක් කිරීම - ඇඩ්මින්ට විතරයි මේ පිටුව අයිති
    Customer user = (Customer) session.getAttribute("loggedUser");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Add New Room</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Poppins', sans-serif; background-color: #f4f6f9; }
            .navbar-custom { background-color: #111; border-bottom: 3px solid #00c851; }
            .form-card { border-radius: 15px; border: none; background-color: white; max-width: 500px; margin: auto; }
            .btn-submit { background-color: #00c851; color: white; font-weight: 600; }
            .btn-submit:hover { background-color: #007e33; color: white; }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
            <div class="container">
                <a class="navbar-brand text-success fw-bold" href="admin_dashboard.jsp">GRAND HORIZON - ADMIN</a>
                <a href="admin_dashboard.jsp" class="btn btn-sm btn-outline-light">Back to Dashboard</a>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="card form-card p-5 shadow-sm">
                <h3 class="fw-bold text-center mb-4">Add New Luxury Room</h3>
                
                <%
                    // කලින් සර්ව්ලට් එකෙන් ආපු මැසේජ් චෙක් කිරීම
                    String status = request.getParameter("status");
                    if ("error".equals(status)) {
                %>
                    <div class="alert alert-danger text-center">Something went wrong! Try again.</div>
                <% } %>

                <form action="AddRoomServlet" method="POST">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Room Number</label>
                        <input type="text" name="roomNumber" class="form-content form-control p-2" placeholder="e.g., 101, 204" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Room Type</label>
                        <select name="roomType" class="form-select p-2" required>
                            <option value="Single Room">Single Room</option>
                            <option value="Double Room">Double Room</option>
                            <option value="Luxury Suite">Luxury Suite</option>
                            <option value="Presidential Suite">Presidential Suite</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Price per Night (LKR)</label>
                        <input type="number" step="0.01" name="price" class="form-control p-2" placeholder="e.g., 15000" required>
                    </div>

                    <button type="submit" class="btn btn-submit w-100 p-2.5">SAVE ROOM TO DATABASE</button>
                </form>
            </div>
        </div>

    </body>
</html>