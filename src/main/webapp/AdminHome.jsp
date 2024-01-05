<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Login Page</title>
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

        /* Modified styling for the navigation bar */
        nav {
            position: absolute;
            top: 0;
            right: 0;
            background: none;
            width: 100%;
        }

        ul.navbar-nav {
            background: none;
            float: right;
            margin-right: 15px;
        }

        ul.navbar-nav li.nav-item {
            margin: 0;
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
    
    
    
</body>
</html>
