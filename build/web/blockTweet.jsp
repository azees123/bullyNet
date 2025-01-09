<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Block Tweet</title>
</head>
<body>
<%
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bn", "root", "");

        // Get tweet ID and user ID from the request
        int tweetId = Integer.parseInt(request.getParameter("tweet_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));

        // SQL to insert into the blocked table
        String sql = "INSERT INTO blocked (tweet_id, users_id) VALUES (?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, tweetId);
        ps.setInt(2, userId);
        ps.executeUpdate();

        // Redirect to a confirmation or blocked user page
        response.sendRedirect("blockedUser.jsp"); // Change this to your desired page
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error blocking tweet: " + e.getMessage() + "</p>");
    } finally {
        // Close resources
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
</body>
</html>
