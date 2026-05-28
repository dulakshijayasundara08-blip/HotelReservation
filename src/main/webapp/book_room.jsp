<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hotel.model.Customer"%>
<%
    // සෙෂන් එක චෙක් කරලා යූසර් ලොග් වෙලාද බලනවා
    Customer user = (Customer) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ඩෑෂ්බෝඩ් එකෙන් එවපු රූම් අයිඩී එක ගන්නවා
    String roomId = request.getParameter("roomId");
    if (roomId == null) {
        response.sendRedirect("RoomListServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Book Your Room</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { 
                font-family: 'Poppins', sans-serif; 
                background: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1920') no-repeat center center fixed;
                background-size: cover;
            }
            .overlay {
                background: rgba(0, 0, 0, 0.6);
                min-height: 100vh;
                width: 100%;
            }
            .navbar-custom { background-color: rgba(17, 17, 17, 0.9); border-bottom: 3px solid #bfa15f; }
            .hotel-brand { color: #bfa15f !important; font-weight: 600; letter-spacing: 2px; }
            
            /* Glassmorphism Card Effect */
            .booking-card { 
                background: rgba(255, 255, 255, 0.15); 
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border-radius: 20px; 
                border: 1px solid rgba(255, 255, 255, 0.2); 
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
                color: white;
            }
            .form-control {
                background: rgba(255, 255, 255, 0.2);
                border: 1px solid rgba(255, 255, 255, 0.3);
                color: white !important;
                border-radius: 10px;
            }
            .form-control:focus {
                background: rgba(255, 255, 255, 0.25);
                box-shadow: none;
                border-color: #bfa15f;
            }
            .btn-confirm { 
                background-color: #bfa15f; 
                color: #111; 
                font-weight: 600; 
                border: none;
                transition: 0.3s ease;
            }
            .btn-confirm:hover { 
                background-color: #a38446; 
                color: white; 
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <div class="overlay">
            <nav class="navbar navbar-expand-lg navbar-dark navbar-custom p-3 shadow">
                <div class="container">
                    <a class="navbar-brand hotel-brand" href="RoomListServlet">GRAND HORIZON</a>
                    <a href="RoomListServlet" class="btn btn-sm btn-outline-light">Back to Rooms</a>
                </div>
            </nav>

            <div class="container mt-5 pt-4">
                <div class="row justify-content-center">
                    <div class="col-md-5">
                        <div class="card booking-card p-5">
                            <h3 class="fw-bold text-center mb-4" style="color: #bfa15f;">Confirm Your Stay</h3>
                            
                            <form action="BookRoomServlet" method="POST">
                                <input type="hidden" name="roomId" value="<%= roomId %>">
                                
                                <div class="mb-4">
                                    <label class="form-label fw-bold">Check-In Date</label>
                                    <input type="date" name="checkInDate" class="form-control" required>
                                </div>
                                
                                <div class="mb-4">
                                    <label class="form-label fw-bold">Check-Out Date</label>
                                    <input type="date" name="checkOutDate" class="form-control" required>
                                </div>
                                
                                <div class="alert alert-light bg-transparent text-white small border-0 p-0 mb-4" style="opacity: 0.8;">
                                    * Total stay cost will be calculated automatically upon confirmation.
                                </div>

                                <button type="submit" class="btn btn-confirm w-100 p-3 fs-5 border-radius-10">CONFIRM & BOOK NOW</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>