<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Product Update</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: 'Verdana', sans-serif;
            background: linear-gradient(to right, #3498db, #2ecc71);
            margin: 0;
            padding: 0;
            height: 100vh;
        }

        h2 {
            color: #e74c3c;
            margin-bottom: 30px;
        }

        .container {
            text-align: center;
            margin-top: 50px; /* Adjust the margin to move it below the navigation bar */
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

        /* Original styling for the navigation bar */
        nav {
            background: none;
            width: 100%;
        }

        ul.navbar-nav {
            float: right;
        }

        ul.navbar-nav li.nav-item {
            border: 2px solid #fff; /* Border color */
            border-radius: 5px; /* Border radius */
            margin-right: 10px; /* Spacing between items */
        }

        ul.navbar-nav li.nav-item a.nav-link {
            padding: 10px; /* Padding inside the border */
            color: #fff; /* Text color */
            font-weight: bold; /* Font weight */
        }

        .navbar-light .navbar-toggler-icon {
            background-color: #fff; /* Change the toggle icon color if needed */
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-sm navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="productadd.jsp">Product Add</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="productdelete.jsp">Product Delete</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="productUpdate.jsp">Product Update</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="productview.jsp">Product View</a>
            </li>
           
        </ul>
    </nav>

    <!-- Centered container using Bootstrap grid system -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="#" method="post">
                    <table>
                        <tr>
                            <td>Product Id:</td>
                            <td><input type="text" name="p1"></td>
                        </tr>
                        <tr>
                            <td>Product Name:</td>
                            <td><input type="text" name="p2"></td>
                        </tr>
                        <tr>
                            <td>Price:</td>
                            <td><input type="text" name="p3"></td>
                        </tr>
                        <tr>
                            <td>Quantity:</td>
                            <td><input type="text" name="q1"></td>
                        </tr>
                        <tr>
                            <td>Image Name:</td>
                            <td><input type="text" name="i1"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
     <%
        String a = request.getParameter("p1");
        String b = request.getParameter("p2");
        String c = request.getParameter("p3");
        String d = request.getParameter("q1");
        String e = request.getParameter("i1");

        if (a != null && b != null && c != null && d != null && e != null) {
            try {
                // choose database
                Class.forName("com.mysql.jdbc.Driver");
                // connect to the database
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");
                // Statement to understand sql query
                Statement st = con.createStatement();

                // Check if the product ID exists
                ResultSet rs = st.executeQuery("SELECT * FROM products WHERE productid=" + a);
                if (rs.next()) {
                    // Product ID exists, perform the update
                    String updateQuery = "UPDATE products SET ";
                    boolean isFirst = true;

                    // Check which fields are present and add them to the update query
                    if (b != null && !b.isEmpty()) {
                        updateQuery += "productname='" + b + "'";
                        isFirst = false;
                    }

                    if (c != null && !c.isEmpty()) {
                        if (!isFirst) {
                            updateQuery += ", ";
                        }
                        updateQuery += "price=" + c;
                        isFirst = false;
                    }

                    if (d != null && !d.isEmpty()) {
                        if (!isFirst) {
                            updateQuery += ", ";
                        }
                        updateQuery += "quantity=" + d;
                        isFirst = false;
                    }

                    if (e != null && !e.isEmpty()) {
                        if (!isFirst) {
                            updateQuery += ", ";
                        }
                        updateQuery += "ImageName='" + e + "'";
                    }

                    // Add the condition for the specific product ID
                    updateQuery += " WHERE productid=" + a;

                    // Execute the update query
                    st.executeUpdate(updateQuery);

                    out.println("<script>alert('Updated successfully')</script>");
                } else {
                    out.println("<script>alert('Product ID does not exist')</script>");
                }

                rs.close();
                st.close();
                con.close();
            } catch (SQLException | ClassNotFoundException ex) {
                out.println(ex);
            }
        }
    %>
</body>
</html>
