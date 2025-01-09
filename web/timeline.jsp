<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Timeline</title>
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
            .tweet-container {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin: 10px 0;
                padding: 15px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .tweet-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .tweet-header h4 {
                margin: 0;
                color: #007bff;
            }
            .tweet-header small {
                color: #888;
            }
            .tweet-message {
                margin: 10px 0;
            }
            img {
                max-width: 200px;
                border-radius: 4px;
                margin-top: 10px;
            }
            .no-tweets {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 15px;
                margin: 10px 0;
                text-align: center;
                color: #777;
            }
            /* Style for the link to Add Tweet */
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
            /* Style for the link to User Dashboard */
            .user-dashboard-link {
                display: block;
                text-align: center;
                margin-top: 10px;
                padding: 10px 15px;
                background-color: #28a745; /* Bootstrap success color */
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .user-dashboard-link:hover {
                background-color: #218838; /* Darker shade on hover */
            }
        </style>
    </head>
    <body>
        <h1>Tweet Timeline</h1>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver"); // Use MySQL Connector/J 8.0 and later
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");

                // SQL to join tweets and users table to get username and email
                String sql = "SELECT t.message, t.file_path, t.created_at, u.username, u.email "
                        + "FROM tweets t JOIN users u ON t.user_id = u.id "
                        + "ORDER BY t.created_at DESC";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                // Check if there are tweets
                if (!rs.isBeforeFirst()) { // Check if result set is empty
                    out.println("<div class='no-tweets'>No tweets available.</div>");
                } else {
                    // Display tweets
                    while (rs.next()) {
                        String message = rs.getString("message");
                        String filePath = rs.getString("file_path");
                        String username = rs.getString("username");
                        String email = rs.getString("email");
                        Timestamp createdAt = rs.getTimestamp("created_at");

                        out.println("<div class='tweet-container'>");
                        out.println("<div class='tweet-header'>");
                        out.println("<h4>" + username + " (" + email + ")</h4>");
                        out.println("<small>Posted on: " + createdAt + "</small>");
                        out.println("</div>");
                        out.println("<div class='tweet-message'>" + message + "</div>");
                        if (filePath != null && !filePath.isEmpty()) {
                            out.println("<img src='" + filePath + "' alt='Uploaded file'/>");
                        }
                        out.println("</div>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error retrieving tweets: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                if (rs != null) try {
                    rs.close();
                } catch (SQLException e) {
                }
                if (ps != null) try {
                    ps.close();
                } catch (SQLException e) {
                }
                if (conn != null) try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        %>

        <a href="tweet.jsp" class="add-tweet-link">Add Tweet</a>
        <a href="userDashboard.jsp" class="user-dashboard-link">User Dashboard</a>
    </body>
</html>
