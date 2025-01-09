<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    // Invalidate the session to log the user out
    session.invalidate();

    // Set a logout message
    request.setAttribute("logoutMessage", "You have successfully logged out.");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <script>
        // Redirect to login page after 2 seconds
        setTimeout(function() {
            window.location.href = 'userLogin.jsp';
        }, 2000);
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 20%;
        }
        .message {
            color: green;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <div class="message">
        <%= request.getAttribute("logoutMessage") %>
    </div>
</body>
</html>
