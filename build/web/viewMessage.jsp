<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<html>
<head>
    <title>View Messages</title>
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
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #d1e7dd;
        }
        .message-row {
            transition: background-color 0.3s;
        }
        .no-messages {
            text-align: center;
            font-style: italic;
            color: #777;
        }
        .profile-pic {
            width: 40px; /* Set a width for the profile picture */
            height: 40px; /* Set a height for the profile picture */
            border-radius: 50%; /* Make it circular */
        }
        a {
            display: block;
            text-align: center;
            margin-top: 15px;
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
    </style>
</head>
<body>
    <h1>Your Messages</h1>
    <table>
        <thead>
            <tr>
                <th>Profile Picture</th>
                <th>Sender</th>
                <th>Message</th>
                <th>Sent At</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                // Get logged-in user ID from session
                Integer userId = (Integer) session.getAttribute("id");

                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");

                    // SQL to get messages for the logged-in user, including sender's profile picture
                    String sql = "SELECT m.content, m.sent_at, u1.username AS sender, m.sender_id "
                               + "FROM messages m "
                               + "JOIN users u1 ON m.sender_id = u1.id "
                               + "WHERE m.receiver_id = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, userId); // Only get messages sent to the logged-in user
                    rs = ps.executeQuery();

                    // Loop through the result set and display messages
                    boolean hasMessages = false;
                    while (rs.next()) {
                        hasMessages = true; // Found at least one message
                        String messageContent = rs.getString("content");
                        String senderUsername = rs.getString("sender");
                        int senderId = rs.getInt("sender_id"); // Get sender ID
                        Timestamp sentAt = rs.getTimestamp("sent_at");

                        out.println("<tr class='message-row'>");
                        out.println("<td><img src='profilePicture?id=" + senderId + "' alt='Profile Picture' class='profile-pic' /></td>");
                        out.println("<td>" + senderUsername + "</td>");
                        out.println("<td>" + messageContent + "</td>");
                        out.println("<td>" + sentAt + "</td>");
                        out.println("</tr>");
                    }

                    // If no messages exist
                    if (!hasMessages) {
                        out.println("<tr><td colspan='4' class='no-messages'>No messages found.</td></tr>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='4' class='no-messages'>Error retrieving messages: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Close resources
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (ps != null) try { ps.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
        </tbody>
    </table>
    <a href="message.jsp">Back to Messages</a>
</body>
</html>
