<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Registration</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: rgba(240, 240, 240, 1);
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 400px;
            }

            h2 {
                text-align: center;
                color: rgba(0, 123, 255, 1);
            }

            label {
                font-weight: bold;
                color: rgba(60, 60, 60, 1);
                display: block;
                margin-bottom: 8px;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid rgba(200, 200, 200, 1);
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="file"] {
                margin-bottom: 15px;
            }

            input[type="submit"] {
                background-color: rgba(0, 123, 255, 1);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                width: 100%;
            }

            input[type="submit"]:hover {
                background-color: rgba(0, 105, 217, 1);
            }

            textarea {
                height: 100px;
                resize: none;
            }

            .form-group {
                margin-bottom: 20px;
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
            <h2>Register User</h2>
            <form action="userRegister" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" name="username" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" required>
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <textarea name="address" required></textarea>
                </div>

                <div class="form-group">
                    <label for="profile_picture">Profile Picture:</label>
                    <input type="file" name="profile_picture" required>
                </div>

                <input type="submit" value="Register">
            </form>

            <div class="register-link">
                <p>Already have an account? <a href="userLogin.jsp">Login here</a></p>
            </div>
        </div>
    </body>
</html>
