<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.ResultSet,java.sql.Statement" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tweets</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                margin: 20px auto;
                padding: 20px;
                width: 90%;
                max-width: 1200px;
                background-color: rgba(255, 255, 255, 0.9);
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 12px;
                text-align: left;
                background-color: rgba(255, 255, 255, 0.8);
            }
            th {
                background-color: rgba(0, 128, 0, 0.1);
                color: #333;
            }
            tr:nth-child(even) td {
                background-color: rgba(0, 128, 0, 0.05);
            }
            tr:hover td {
                background-color: rgba(0, 128, 0, 0.1);
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
        <div class="container">
            <h1>Tweets Details</h1>
            <table>
                <thead>
                    <tr>
                        <th>Tweet Id</th>
                        <th>User Id</th>
                        <th>Message</th>
                        <th>Photo</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String DB_URL = "jdbc:mysql://localhost:3306/bn";
                        String DB_USER = "root";
                        String DB_PASSWORD = "";

                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                            String sql = "SELECT id, user_id, message, file_path FROM tweets"; // Adjust table name as necessary
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);

                            if (!rs.isBeforeFirst()) {
                                // No records found
                                out.println("<tr><td colspan='4' style='text-align:center;'>No tweets found.</td></tr>");
                            } else {
                                while (rs.next()) {
                                    int tweetId = rs.getInt("id");
                                    int userId = rs.getInt("user_id");
                                    String message = rs.getString("message");
                                    String filePath = rs.getString("file_path");
                    %>
                    <tr>
                        <td><%= tweetId%></td>
                        <td><%= userId%></td>
                        <td><%= message%></td>
                        <td>
                            <% if (filePath != null && !filePath.isEmpty()) {%>
                            <img src="<%= filePath%>" alt="Photo" style="width: 50px; height: 50px; border-radius: 50%;">
                            <% } else { %>
                            No Photo
                            <% } %>
                        </td>
                    </tr>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='4' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (stmt != null) {
                                    stmt.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <a href="adminDashboard.jsp" class="add-tweet-link">Admin Dashboard</a>
    </body>
</html>
