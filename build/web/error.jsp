<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #d9534f; /* Bootstrap danger color */
            text-align: center;
        }
        p {
            text-align: center;
            color: #333;
        }
        a {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
            padding: 10px 15px;
            background-color: #e9ecef;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        a:hover {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Error Occurred</h1>
    <p>There was an error sending your message. Please try again later.</p>
    <a href="userDashboard.jsp">Go Back to Dashboard</a>
</body>
</html>
