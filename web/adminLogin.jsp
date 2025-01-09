<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Login Page</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            /* Basic styling for the login page */
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                background: #f0f8ff;
                color: #333;
            }

            .container {
                width: 80%;
                max-width: 400px;
                margin: 2rem auto;
                padding: 2rem;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                margin-bottom: 1rem;
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                margin-bottom: 0.5rem;
                font-weight: bold;
            }

            input[type="email"], input[type="password"], input[type="text"] {
                padding: 0.75rem;
                margin-bottom: 1rem;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            button {
                padding: 0.75rem;
                background-color: rgba(52, 73, 94, 1);
                border: none;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
            }

            button:hover {
                background: #333;
            }

            .register-link {
                text-align: center;
                margin-top: 1rem;
            }

            .register-link a {
                color: rgba(52, 73, 94, 1);
                text-decoration: none;
                font-weight: bold;
            }

            .register-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1> Admin Login Page</h1>
            <form action="LoginAdmin" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <button type="submit">Login</button>
            </form>

            <div class="register-link">
                <p>Don't have an account? <a href="userRegister.jsp">Register here</a></p>
                <p>Back to <a href="index.html">Home</a></p>
            </div>
        </div>
    </body>
</html>
