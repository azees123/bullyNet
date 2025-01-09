<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.ResultSet,java.sql.Statement, java.io.ByteArrayOutputStream, java.io.InputStream, java.util.Base64" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
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
        .login-link {
            text-align: center;
            margin-top: 1rem;
        }
        .login-link a {
            color: green;
            text-decoration: none;
            font-weight: bold;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
        img {
            width: 50px; /* Set the desired width */
            height: 50px; /* Set the desired height */
            border-radius: 50%; /* Make the image circular */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Details</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Profile Picture</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Address</th>
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
                        String sql = "SELECT id, username, email, password, address, profile_picture FROM users";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        if (!rs.isBeforeFirst()) {
                            // No records found
                            out.println("<tr><td colspan='6' style='text-align:center;'>No files uploaded.</td></tr>");
                        } else {
                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String fullName = rs.getString("username"); // Adjusted to use username
                                String email = rs.getString("email");
                                String password = rs.getString("password");
                                String address = rs.getString("address");
                                InputStream profilePictureStream = rs.getBinaryStream("profile_picture");

                                String profilePictureBase64 = null;
                                if (profilePictureStream != null) {
                                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                                    byte[] buffer = new byte[1024];
                                    int bytesRead;

                                    while ((bytesRead = profilePictureStream.read(buffer)) != -1) {
                                        baos.write(buffer, 0, bytesRead);
                                    }
                                    byte[] imageBytes = baos.toByteArray();
                                    profilePictureBase64 = Base64.getEncoder().encodeToString(imageBytes);
                                }
                %>
                <tr>
                    <td><%= id %></td>
                    <td><img src="data:image/png;base64,<%= profilePictureBase64 != null ? profilePictureBase64 : "" %>" alt="Profile Picture"></td>
                    <td><%= fullName %></td>
                    <td><%= email %></td>
                    <td><%= password %></td>
                    <td><%= address %></td>
                </tr>
                <%
                            }
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <div class="login-link">
        <p>Back <a href="adminDashboard.jsp">to Admin Dashboard</a></p>
    </div>
</body>
</html>
