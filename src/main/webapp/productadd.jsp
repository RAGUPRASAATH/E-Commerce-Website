<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Product Add</title>
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
               <form action="UploadServlet" method="post" enctype="multipart/form-data">
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
        <td>Image File:</td>
        <td><input type="file" name="file"></td>
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
        String productId = request.getParameter("p1");
        String productName = request.getParameter("p2");
        String price = request.getParameter("p3");
        String quantity = request.getParameter("q1");
        String imageName = request.getParameter("i1");

        if (productId != null && productName != null && price != null && quantity != null && imageName != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");
                PreparedStatement pt = con.prepareStatement("insert into products values(?, ?, ?, ?, ?)");

                pt.setString(1, productId);
                pt.setString(2, productName);
                pt.setString(3, price);
                pt.setString(4, quantity);
                pt.setString(5, imageName);

                pt.executeUpdate();
                out.println("<script>alert('Insert successfully')</script>");

                con.close(); // Close the connection

            } catch (SQLException | ClassNotFoundException e) {
                out.println("<script>alert('Error: " + e.getMessage() + "')</script>");
                e.printStackTrace(new PrintWriter(out));
            }
        }
    %>
     <%-- Check for success message attribute and display it --%>
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        if (successMessage != null && !successMessage.isEmpty()) {
    %>
        <script>alert('<%= successMessage %>')</script>
    <%
        }
    %>
</body>
</html>
