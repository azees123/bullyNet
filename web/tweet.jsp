<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.annotation.MultipartConfig" %>
<%@ page import="jakarta.servlet.annotation.WebServlet" %>
<%@ page import="jakarta.servlet.http.Part" %>
<html>
    <head>
        <title>Submit Tweet</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 20px;
            }
            h1 {
                color: #333;
                text-align: center;
            }
            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                margin: auto;
            }
            textarea {
                width: 100%;
                height: 100px;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                resize: none;
                margin-bottom: 10px;
            }
            input[type="file"] {
                margin-bottom: 10px;
            }
            button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                width: 100%; /* Full width button */
            }
            button:hover {
                background-color: #218838; /* Darker green on hover */
            }
            a {
                display: block;
                margin-top: 15px;
                text-align: center;
                color: #007bff;
                text-decoration: none;
                padding: 10px 15px;
                background-color: #e9ecef; /* Light gray background */
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            a:hover {
                background-color: #007bff; /* Darker blue on hover */
                color: white; /* Change text color on hover */
            }
            .add-tweet-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                padding: 10px 15px;
                background-color: #007bff; /* Bootstrap primary color */
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .add-tweet-link:hover {
                background-color: #0056b3; /* Darker shade on hover */
            }
        </style>
    </head>
    <body>
        <h1>Submit a New Tweet</h1>
        <form action="submitTweet" method="post" enctype="multipart/form-data">
            <textarea name="message" placeholder="What's happening?" required></textarea>
            <input type="file" name="file" accept="image/*">
            <!-- Hidden field to pass the user ID -->
            <input type="hidden" name="userId" value="<%= (session.getAttribute("id") != null) ? session.getAttribute("id") : ""%>">
            <button type="submit">Tweet</button> <!-- Styled button -->
        </form>
        <a href="timeline.jsp">View Timeline</a>
        <a href="userDashboard.jsp" class="add-tweet-link">User Dashboard</a>
    </body>
</html>
