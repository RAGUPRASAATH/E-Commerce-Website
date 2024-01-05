<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    String securityQuestion = "";

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Connect to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");

        // Create a statement to execute SQL queries
        Statement st = con.createStatement();

        // Execute the SQL query to retrieve the security question based on the provided username
        ResultSet rs = st.executeQuery("SELECT SecurityQuestion FROM RegisterLogindatas WHERE name='" + username + "'");

        // Check if a result is found
        if (rs.next()) {
            // Retrieve security question
            securityQuestion = rs.getString("SecurityQuestion");
        }

        // Close the resources
        rs.close();
        st.close();
        con.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }

    out.print(securityQuestion);
%>
