<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
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
        function showSecurityQuestionForm(securityQuestion) {
            document.getElementById("entireForm").style.display = "none";
            document.getElementById("securityQuestionForm").style.display = "block";
            document.getElementById("securityQuestionText").innerHTML = 'Security Question: ' + securityQuestion;
        }

        function verifySecurityAnswer() {
            var securityAnswer = document.getElementById("securityAnswer").value;

            // Use AJAX to check if the security answer is correct
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var isCorrectSecurityAnswer = xhr.responseText.trim() === "true";

                    if (isCorrectSecurityAnswer) {
                        // Security answer is correct, proceed to change password
                        document.getElementById("securityAnswerForm").submit();
                    } else {
                        // Security answer is wrong, show an alert
                        alert("Security answer is incorrect. Please try again.");
                    }
                }
            };

            xhr.open("POST", "CheckSecurityAnswer.jsp", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            var username = document.getElementById("usernameInput").value;
            xhr.send("username=" + username + "&securityAnswer=" + securityAnswer);

            // Prevent the default form submission
            return false;
        }

        function checkUsername() {
            var username = document.getElementById("usernameInput").value;
            var xhr = new XMLHttpRequest();

            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var response = xhr.responseText.trim();
                    if (response !== "") {
                        // Extracted security question from the response
                        var securityQuestion = response;
                        // Username exists, proceed to show the security question form.
                        showSecurityQuestionForm(securityQuestion);
                    } else {
                        // Username doesn't exist, show an alert message.
                        alert("Username does not exist. Please enter a valid username.");
                    }
                }
            };

            xhr.open("GET", "CheckUsernameExists.jsp?username=" + username, true);
            xhr.send();
            return false; // Prevent the default form submission
        }
    </script>
</head>
<body>
    <div id="entireForm">
        <form action="#" method="post" onsubmit="return checkUsername();">
            <div>
                Username: <input type="text" id="usernameInput" name="t1" required>
                <input type="submit" value="Submit">
            </div>
        </form>
    </div>

    <div id="securityQuestionForm" style="display: none;">
        <form id="securityAnswerForm" action="ChangePassword.jsp" method="post">
            <p id="securityQuestionText"></p>
            Security Answer: <input type="text" id="securityAnswer" name="securityAnswer" required>
            <input type="button" value="Verify Security Answer" onclick="verifySecurityAnswer()">
        </form>
    </div>

    <%
        String a = request.getParameter("t1");
                
        if(a != null){
            try{
                // Load the JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                
                // Connect to the database
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");
                
                // Create a statement to execute SQL queries
                Statement st = con.createStatement();
                
                // Execute the SQL query to retrieve user data based on the provided username
                ResultSet rs = st.executeQuery("SELECT * FROM RegisterLogindatas WHERE name='" + a + "'");
                
                // Check if a result is found
                if(rs.next()){
                    // Retrieve security question
                    String securityQuestion = rs.getString("SecurityQuestion");
                    
                    // Display the security question using JavaScript
                    out.println("<script>");
                    out.println("showSecurityQuestionForm('" + securityQuestion + "');");
                    out.println("</script>");
                } else {
                    // No user found with the provided username
                    out.println("<p>No user found with the provided username.</p>");
                }
                
                // Close the resources
                rs.close();
                st.close();
                con.close();
            } catch(SQLException | ClassNotFoundException e){
                out.println(e);
            }
        }
    %>

</body>
</html>
