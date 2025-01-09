<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Bullying Tweets</title>
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
                margin: 20px 0;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ccc;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .no-tweets {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 15px;
                text-align: center;
                color: #777;
                margin: 20px 0;
            }
            img {
                max-width: 100px; /* Limit image width */
                border-radius: 4px;
            }
            .block-button {
                background-color: #dc3545; /* Red color for block button */
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
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
        <h1>Bullying Tweets</h1>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            List<String> bullyingWords = Arrays.asList("bully", "hate", "stupid", "idiot", "loser"); // Add more as needed

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");

                // SQL to fetch all tweets along with the username
                String sql = "SELECT t.id AS tweet_id, t.user_id, t.message, t.file_path, u.username "
                        + "FROM tweets t JOIN users u ON t.user_id = u.id";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                boolean hasBullyingTweets = false; // Flag to check if there are any bullying tweets

                // Start the table
                out.println("<table>");
                out.println("<tr><th>Username</th><th>User ID</th><th>Tweet ID</th><th>Message</th><th>File</th><th>Action</th></tr>");

                // Display tweets that contain bullying words
                while (rs.next()) {
                    int tweetId = rs.getInt("tweet_id");
                    int userId = rs.getInt("user_id");
                    String message = rs.getString("message");
                    String filePath = rs.getString("file_path");
                    String username = rs.getString("username");

                    // Check for bullying words in the message
                    for (String word : bullyingWords) {
                        if (message.toLowerCase().contains(word.toLowerCase())) {
                            hasBullyingTweets = true; // Found a bullying tweet
                            out.println("<tr>");
                            out.println("<td>" + username + "</td>");
                            out.println("<td>" + userId + "</td>");
                            out.println("<td>" + tweetId + "</td>");
                            out.println("<td>" + message + "</td>");
                            out.print("<td>");
                            if (filePath != null && !filePath.isEmpty()) {
                                out.println("<img src='" + filePath + "' alt='Uploaded file'/>");
                            } else {
                                out.println("No file");
                            }
                            out.println("</td>");
                            out.println("<td>");
                            out.println("<form action='blockTweet.jsp' method='post'>"); // Action to block the tweet
                            out.println("<input type='hidden' name='tweet_id' value='" + tweetId + "'/>");
                            out.println("<input type='hidden' name='user_id' value='" + userId + "'/>");
                            out.println("<input type='submit' class='block-button' value='Block'/>");
                            out.println("</form>");
                            out.println("</td>");
                            out.println("</tr>");
                            break; // Break out of the for loop if a bullying word is found
                        }
                    }
                }

                // Close the table
                out.println("</table>");

                // If no bullying tweets found
                if (!hasBullyingTweets) {
                    out.println("<div class='no-tweets'>No bullying tweets found.</div>");
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
        <a href="adminDashboard.jsp" class="add-tweet-link">Admin Dashboard</a>
    </body>
</html>
