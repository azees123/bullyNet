<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tweets Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        #tweetsChart {
            display: block;
            margin: 0 auto;
            width: 80%; /* Medium size */
            max-width: 600px; /* Max width for responsiveness */
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 16px;
            text-decoration: none;
            color: #007bff;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .download-btn {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .download-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Tweets Chart</h2>
    
    <canvas id="tweetsChart" width="400" height="200"></canvas>
    
    <!-- Anchor link to navigate back to adminDashboard.jsp -->
    <a class="back-link" href="adminDashboard.jsp">Back to Admin Dashboard</a>
    
    <!-- Button to download chart -->
    <button class="download-btn" id="downloadBtn">Download Chart</button>
    
    <script>
        const ctx = document.getElementById('tweetsChart').getContext('2d');

        // Values for tweets and blocked counts
        let totalTweets = 0;
        let totalBlocked = 0;

        <% 
        String url = "jdbc:mysql://localhost:3306/bn"; // Update with your DB URL
        String user = "root"; // Update with your DB username
        String password = ""; // Update with your DB password

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();
            String sql = "SELECT (SELECT COUNT(*) FROM tweets) AS total_tweets, "
                       + "(SELECT COUNT(*) FROM blocked) AS total_blocked";
            rs = stmt.executeQuery(sql);

            if (rs.next()) {
                // Use out.println to directly output the values to the JavaScript context
                out.println("totalTweets = " + rs.getInt("total_tweets") + ";");
                out.println("totalBlocked = " + rs.getInt("total_blocked") + ";");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>

        // Now use the variables in JavaScript
        const tweetsChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Total Tweets', 'Total Blocked'],
                datasets: [{
                    label: '# of Tweets',
                    data: [totalTweets, totalBlocked],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(255, 99, 132, 0.6)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 99, 132, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Download chart as image
        document.getElementById('downloadBtn').addEventListener('click', function() {
            const link = document.createElement('a');
            link.href = tweetsChart.toBase64Image();
            link.download = 'tweets_chart.png';
            link.click();
        });
    </script>
</body>
</html>
