<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Blocked Tweets</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: rgba(0, 123, 255, 0.7);
                color: white;
            }
            tr:nth-child(even) {
                background-color: rgba(240, 240, 240, 0.9);
            }
            img {
                max-width: 100px;
                height: auto;
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
            h1{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Blocked Tweets</h1>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");

                // SQL to fetch blocked tweets along with the username
                String sql = "SELECT b.tweet_id, b.users_id, t.message, t.file_path, u.username "
                        + "FROM blocked b JOIN tweets t ON b.tweet_id = t.id "
                        + "JOIN users u ON b.users_id = u.id";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                // Start displaying blocked tweets in a table
                out.println("<table>");
                out.println("<tr><th>User Name</th><th>Tweet ID</th><th>Message</th><th>File</th></tr>");

                boolean foundTweets = false; // To check if there are any blocked tweets
                while (rs.next()) {
                    foundTweets = true;
                    int tweetId = rs.getInt("tweet_id");
                    int userId = rs.getInt("users_id");
                    String message = rs.getString("message");
                    String filePath = rs.getString("file_path");
                    String username = rs.getString("username");

                    out.println("<tr>");
                    out.println("<td>" + username + "</td>");
                    out.println("<td>" + tweetId + "</td>");
                    out.println("<td>" + message + "</td>");
                    if (filePath != null && !filePath.isEmpty()) {
                        out.println("<td><img src='" + filePath + "' alt='Uploaded file'/></td>");
                    } else {
                        out.println("<td>No file</td>");
                    }
                    out.println("</tr>");
                }

                if (!foundTweets) {
                    out.println("<tr><td colspan='4'>No blocked tweets found.</td></tr>");
                }
                out.println("</table>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error retrieving blocked tweets: " + e.getMessage() + "</p>");
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
        <a href="adminDashboard.jsp" class="add-tweet-link">Admin Dashboard</a>
    </body>
</html>
