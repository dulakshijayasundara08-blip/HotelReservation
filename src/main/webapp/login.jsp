<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grand Horizon | Login</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                            url('https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1920') no-repeat center center fixed;
                background-size: cover;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .glass-card {
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 15px;
                color: #fff;
                box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            }
            .form-control {
                background: rgba(255, 255, 255, 0.2);
                border: 1px solid rgba(255, 255, 255, 0.2);
                color: #fff;
                border-radius: 8px;
            }
            .form-control:focus {
                background: rgba(255, 255, 255, 0.3);
                border-color: #fff;
                color: #fff;
                box-shadow: none;
            }
            .btn-custom {
                background: linear-gradient(135deg, #c5a880, #e6cfa7);
                color: #000;
                font-weight: 600;
                border: none;
                border-radius: 8px;
                padding: 10px;
                transition: 0.3s;
            }
            .btn-custom:hover {
                background-color: #fff;
                transform: translateY(-2px);
            }
            .hotel-title {
                color: #d4af37;
                font-weight: 600;
                letter-spacing: 2px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="card glass-card p-4">
                        <div class="text-center mb-4">
                            <h2 class="hotel-title mb-1">GRAND HORIZON</h2>
                            <p class="text-light-50 small">Welcome Back</p>
                            <hr style="border-color: rgba(255,255,255,0.2);">
                        </div>
                        
                        <form action="LoginServlet" method="POST">
                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                            </div>
                            <button type="submit" class="btn btn-custom w-100 mt-3">LOGIN</button>
                        </form>
                        
                        <div class="text-center mt-3 small">
                            <span class="text-white-50">Don't have an account?</span> <a href="register.jsp" style="color: #d4af37; text-decoration: none; font-weight: 600;">Register</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>