<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if the user is logged in by verifying the session attribute
    if (session.getAttribute("userEmail") == null) {
        // Redirect to the login page if the user is not logged in
        response.sendRedirect("index.html");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <style>
            html, body {
                height: 100%; /* Set full height */
                margin: 0;
                overflow: hidden; /* Prevent scrollbars */
            }

            body {
                background: url('icon/download.jpg') no-repeat center center fixed;
                background-size: cover;
                color: #fff;
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
            }

            header {
                background-color: rgba(34, 47, 62, 0.95); /* Deep blue-gray */
                padding: 30px 0; /* Increased top and bottom padding */
                text-align: center;
                position: sticky;
                top: 0;
                width: 100%;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                z-index: 1000;
            }

            h1 {
                font-size: 36px;
                margin: 0;
                color: #f1c40f; /* Bright golden yellow */
                letter-spacing: 2px;
                text-transform: uppercase;
                font-weight: bold;
            }

            .navbar {
                display: flex;
                justify-content: center;
                margin-top: 15px; /* Added margin above navbar */
                border-bottom: 1px solid rgba(241, 196, 15, 0.5); /* Line separator */
                padding-bottom: 10px; /* Space between navbar and line */
            }

            .nav-links {
                list-style: none;
                display: flex;
                padding: 0;
                margin: 0;
            }

            .nav-links li {
                margin: 0 25px; /* Increased margin between nav items */
            }

            .nav-links a {
                text-decoration: none;
                color: #f1c40f;
                font-size: 14px;
                padding: 12px 20px; /* Increased padding for nav links */
                transition: background-color 0.3s ease, color 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1.2px;
                font-weight: 500;
                border-radius: 5px;
                position: relative;
            }

            .nav-links a:hover {
                background-color: rgba(241, 196, 15, 0.2); /* Light golden on hover */
                color: #ffffff;
            }

            main {
                padding: 20px;
                background: rgba(50, 50, 50, 0.8);
                margin: 20px; /* Add margin to create space */
                border-radius: 8px;
                flex: 1; /* Allows main to grow and fill space */
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                overflow-y: auto; /* Allow scrolling within the main area if content overflows */
            }

            h2 {
                font-size: 2.5em;
                margin-bottom: 20px;
                color: #ecf0f1;
            }

            p {
                font-size: 1.3em;
                color: #f39c12;
                text-align: center;
                line-height: 1.6;
            }

            footer {
                background-color: rgba(34, 47, 62, 0.95);
                text-align: center;
                padding: 15px;
                position: relative;
                bottom: 0;
                width: 100%;
                box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.2);
            }

            footer p {
                margin: 0;
                color: #f1c40f;
                font-size: 1em;
                letter-spacing: 1px;
            }
        </style>
    </head>
    <body>
        <header>
            <h1>User Dashboard</h1>
            <nav class="navbar">
                <ul class="nav-links">
                    <li><a href="adminDashboard.jsp">Home</a></li>
                    <li><a href="userDetails.jsp">User Details</a></li>
                    <li><a href="UserTweet.jsp">User Tweet</a></li>
                    <li><a href="bullyTweet.jsp">Bullying Tweet</a></li>
                    <li><a href="blockedUser.jsp">Blocked Users</a></li>
                    <li><a href="graph.jsp">Graph</a></li>
                    <li><a href="userLogout.jsp">Logout</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <section id="welcome">
                <h2>
                    Welcome, 
                    <%= (session.getAttribute("fullName") != null) ? session.getAttribute("fullName") : "Guest"%>!
                </h2>
                <p>
                    You are logged in as 
                    <strong><%= (session.getAttribute("userEmail") != null) ? session.getAttribute("userEmail") : "N/A"%></strong>.
                </p>
            </section>
        </main>
        <footer>
            <p>&copy; 2024 Copy Rights</p>
        </footer>
    </body>
</html>
