<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session එක සම්පූර්ණයෙන්ම මකා දමනවා (Clear Session)
    session.invalidate();
    
    // ආපහු ලොගින් පේජ් එකට හරවා යවනවා
    response.sendRedirect("login.jsp");
%>