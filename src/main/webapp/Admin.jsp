<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Login Page</title>
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

        h2 {
            color: #e74c3c;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: bold;
            text-align: left;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 2px solid #3498db;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
            color: #1a237e;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #2ecc71;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #27ae60;
        }

        a {
            text-decoration: none;
            color: #311b92;
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <form action="#" method="post">
        <h2>Admin Login</h2>
        <label for="t1">Username:</label>
        <input type="text" name="t1" id="t1" required>

        <label for="p1">Password:</label>
        <input type="password" name="p1" id="p1" required>

        <input type="submit" value="Login">
        
        
    </form>

    <%
    String a = request.getParameter("t1");
    String b = request.getParameter("p1");
    int rowsAffected = 0;

    if (a != null && b != null) {
        try {
            // Dynamically load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");

            // Statement to understand SQL query
            Statement st = con.createStatement();

            // Check if the username and password are correct
            ResultSet existingUser = st.executeQuery("SELECT * FROM AdminLogindatas WHERE name='" + a + "' AND password='" + b + "'");
            if (existingUser.next()) {
                // Redirect to home page on successful login
                response.sendRedirect("AdminHome.jsp");
            } else {
                out.println("<script>alert('Invalid login credentials. Please try again.');</script>");
            }

            existingUser.close();
            st.close();
            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            out.println("<script>alert('" + e.getMessage() + "')</script>");
        }
    }
    %>
</body>
</html>
