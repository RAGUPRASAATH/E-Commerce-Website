<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>
    <style>
         body {
            font-family: 'Verdana', sans-serif;
            background: linear-gradient(to right, #3498db, #2ecc71);
            margin: 100px 0 0 0; 
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h2 {
            color: #e74c3c;
            
        }

        label {
            display: block;
            margin-bottom: 15px;
            color: #2c3e50;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 15px;
            box-sizing: border-box;
            border: 2px solid #3498db;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 16px;
            color: #2c3e50;
        }

        input[type="submit"] {
            background-color: #2ecc71;
            color: #ffffff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #27ae60;
        }

        a {
            text-decoration: none;
            color: #e67e22;
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }
        .error-message {
            color: #e74c3c;
            margin-top: 5px;
        }
    </style>
       <script>
        function validatePassword() {
            var password = document.getElementById("p1").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var errorMessage = document.getElementById("error-message");

            if (password !== confirmPassword) {
                errorMessage.innerHTML = "Passwords do not match";
                return false;
            } else {
                errorMessage.innerHTML = "";
                return true;
            }
        }
    </script>
</head>
<body>
    <form action="#" method="post">
        <h2>Registration</h2>
        <label for="t1">Username:</label>
        <input type="text" name="t1" id="t1" required>

        <label for="p1">Password:</label>
        <input type="password" name="p1" id="p1" required>
        
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" name="confirmPassword" id="confirmPassword" required oninput="validatePassword()">
        <div class="error-message" id="error-message"></div>
        
        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required>

        <label for="securityQuestion">Security Question:</label>
        <select name="securityQuestion" id="securityQuestion" required>
            <option value="What is your favorite cricket player?">What is your favorite cricket player?</option>
            <option value="What is the name of your first pet?">What is the name of your first pet?</option>
            <option value="What is the name of your favorite anime?">What is the name of your favorite anime?</option>
            <option value="What is the name of your favorite Game?">What is the name of your favorite Game?</option>
        </select>

        <label for="securityAnswer">Security Answer:</label>
        <input type="password" name="securityAnswer" id="securityAnswer" required>

        <input type="submit" value="Sign up">

        <%
        String a = request.getParameter("t1");
        String b = request.getParameter("p1");
        String email = request.getParameter("email");
        String securityQuestion = request.getParameter("securityQuestion");
        String securityAnswer = request.getParameter("securityAnswer");
        int rowsAffected = 0;

        if (a != null && b != null && email != null && securityQuestion != null && securityAnswer != null) {
            try {
                // Dynamically load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Connect to the database
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");

                // Statement to understand SQL query
                Statement st = con.createStatement();

                // Check if the username already exists
                ResultSet existingUser = st.executeQuery("SELECT * FROM RegisterLogindatas WHERE name='" + a + "'");
                if (existingUser.next()) {
                    // Username already exists, handle accordingly (e.g., display an error message)
                    out.println("<script>alert('Username already exists.')</script>");
                } else {
                    // Insert new user into the table
                    rowsAffected = st.executeUpdate("INSERT INTO RegisterLogindatas(Name,Password,Email,SecurityQuestion,SecurityAnswer)VALUES ('" + a + "','" + b + "','" + email + "','" + securityQuestion + "','" + securityAnswer + "')");
                    if (rowsAffected > 0) {
                        out.println("<script>alert('Username successfully inserted.')</script>");
                        out.println("<script>setTimeout (function(){window.location.href='Register,LoginandAdmin.jsp';},1000);</script>");
                    } else {
                        out.println("<script>alert('Error inserting username.')</script>");
                    }
                }

                existingUser.close();
                st.close();
                con.close();
            } catch (SQLException | ClassNotFoundException e) {
                out.println("<script>alert('" + e.getMessage() + "')</script>");
            }
        }
        %>

    </form>
</body>
</html>
