<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
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

        form {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: center;
            color: #333333;
        }

        input {
            width: 100%;
            padding: 10px;
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

        p {
            color: #e74c3c;
            margin-bottom: 20px;
        }
    </style>
     <script>
        function redirectAfterDelay() {
            setTimeout(function() {
                window.location.href = 'Login.jsp';
            }, 1000); // 1000 milliseconds = 1 second
        }
    </script>
</head>
<body>
    <form action="#" method="post">
        <div>
            New Password: <input type="password" name="newPassword" required>
        </div>
        <div>
            Confirm Password: <input type="password" name="confirmPassword" required>
        </div>
        <input type="submit" value="Change Password">

        <%
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            if (newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword)) {
                // Retrieve the username and security answer from the session (set in the previous page)
                String username = (String) session.getAttribute("username");
                String securityAnswer = (String) session.getAttribute("securityAnswer");

                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    // Connect to the database
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");

                    // Create a statement to execute SQL queries
                    Statement st = con.createStatement();

                    // Check if the security answer is correct
                    ResultSet rs = st.executeQuery("SELECT * FROM RegisterLogindatas WHERE name='" + username + "' AND SecurityAnswer='" + securityAnswer + "'");
                    if (rs.next()) {
                        // Update the password
                        PreparedStatement updateStatement = con.prepareStatement("UPDATE RegisterLogindatas SET Password=? WHERE name=?");
                        updateStatement.setString(1, newPassword);
                        updateStatement.setString(2, username);
                        updateStatement.executeUpdate();
                        updateStatement.close();  // Move the close statement here
                        out.println("<p>Password changed successfully!</p>");
                        
                        out.println("<script>redirectAfterDelay();</script>");
                    } else {
                        out.println("<p>Invalid security answer.</p>");
                    }

                    // Close the resources
                    rs.close();
                    st.close();
                    con.close();
                } catch (SQLException | ClassNotFoundException e) {
                    out.println(e);
                }
            } else if (newPassword != null && confirmPassword != null && !newPassword.equals(confirmPassword)) {
                out.println("<p>Passwords do not match.</p>");
            }
        %>
    </form>
</body>
</html>
