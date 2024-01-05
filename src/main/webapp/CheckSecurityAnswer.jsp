<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    String securityAnswer = request.getParameter("securityAnswer");
    boolean isCorrectSecurityAnswer = false;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Connect to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");

        // Create a statement to execute SQL queries
        Statement st = con.createStatement();

        // Execute the SQL query to retrieve security answer based on the provided username
        ResultSet rs = st.executeQuery("SELECT SecurityAnswer FROM RegisterLogindatas WHERE name='" + username + "'");

        // Check if a result is found
        if (rs.next()) {
            // Retrieve security answer
            String actualSecurityAnswer = rs.getString("SecurityAnswer");

            // Check if the provided security answer matches the actual security answer
            isCorrectSecurityAnswer = actualSecurityAnswer.equals(securityAnswer);

            if (isCorrectSecurityAnswer) {
                // If the security answer is correct, set it in the session
                session.setAttribute("username", username);
                session.setAttribute("securityAnswer", securityAnswer);
            }
        }

        // Close the resources
        rs.close();
        st.close();
        con.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }

    out.print(isCorrectSecurityAnswer);
%>
