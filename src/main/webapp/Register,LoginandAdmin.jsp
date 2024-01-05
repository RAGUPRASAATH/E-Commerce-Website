<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login/Register/Admin Page</title>
    <style>
        body {
            font-family: 'Verdana', sans-serif;
            background: linear-gradient(to right, #3498db, #2ecc71);
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            color: #333333;
            display: flex;
            flex-direction: row;
            justify-content: space-between; /* Use space-between to have space at both ends */
        }

        form {
            width: 30%; /* Adjust the width as needed */
            margin-right: 20px; /* Add margin to create space between forms */
            display: inline-block;
        }

        button {
            padding: 15px;
            width: 100%;
            background-color: #2ecc71;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #27ae60;
        }
    </style>
</head>
<body>

    <div class="container">
        <form id="loginForm" action="login.jsp" method="post">
            <button type="button" onclick="redirectTo('Login.jsp')">Login</button>
        </form>

        <form id="registerForm" action="Register.jsp" method="post">
            <button type="button" onclick="redirectTo('Register.jsp')">Register</button>
        </form>

        <form id="adminForm" action="Admin.jsp" method="post">
            <button type="button" onclick="redirectTo('Admin.jsp')">Admin</button>
        </form>
    </div>

    <script>
        function redirectTo(page) {
            window.location.href = page;
        }
    </script>

</body>
</html>
