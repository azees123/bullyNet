<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<html>
    <head>
        <title>Following Users</title>
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
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                border: 1px solid #ccc;
                text-align: left;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
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
        <h1>Users You Are Following</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Profile Picture</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    // Get logged-in user ID from session
                    Integer loggedInUserId = (Integer) session.getAttribute("id");

                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");

                        // SQL to get users that the logged-in user is following
                        String sql = "SELECT u.id, u.username, u.profile_picture FROM follows f "
                                + "JOIN users u ON f.followed_id = u.id "
                                + "WHERE f.follower_id = ?";
                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, loggedInUserId);
                        rs = ps.executeQuery();

                        // Check if the user is following anyone
                        if (!rs.isBeforeFirst()) {
                            out.println("<tr><td colspan='3' style='text-align:center;'>No following users.</td></tr>");
                        } else {
                            // Loop through the result set and display followed users
                            while (rs.next()) {
                                int followedId = rs.getInt("id");
                                String username = rs.getString("username");
                                Blob profilePictureBlob = rs.getBlob("profile_picture");

                                String profilePictureUrl = "profilePicture?id=" + followedId; // URL to fetch profile picture

                                out.println("<tr>");
                                out.println("<td>" + followedId + "</td>");
                                out.println("<td>" + username + "</td>");
                                out.println("<td><img src='" + profilePictureUrl + "' alt='Profile Picture'/></td>");
                                out.println("</tr>");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='3'>Error retrieving following users: " + e.getMessage() + "</td></tr>");
                    } finally {
                        // Close resources
                        if (rs != null) try { rs.close(); } catch (SQLException e) {}
                        if (ps != null) try { ps.close(); } catch (SQLException e) {}
                        if (conn != null) try { conn.close(); } catch (SQLException e) {}
                    }
                %>
            </tbody>
        </table>
        <a href="allPeoples.jsp">Add Followings</a>
        <a href="userDashboard.jsp" class="user-dashboard-link">User Dashboard</a>
    </body>
</html>
