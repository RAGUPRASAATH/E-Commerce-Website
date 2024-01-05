<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Laptop Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #2980b9, #27ae60);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow-x: hidden;
        }

        #header {
            text-align: center;
            color: #fff;
            padding: 20px;
            background: #2c3e50;
            width: 100%;
        }

        h1 {
            margin: 0;
        }

        p {
            margin-top: 10px;
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
            background: none;
            width: 100%;
            justify-content: center; 
            margin-top:20px;
            margin-right:-300px;
        }

        ul.navbar-nav {
            background: none;
            display: flex;
            justify-content: center;
            margin-top: 20px;
            list-style: none;
            padding: 0;
        }

        ul.navbar-nav li.nav-item {
            margin: 0;
            border: 2px solid #fff;
            border-radius: 5px;
            margin-right: 10px;
        }

        ul.navbar-nav li.nav-item a.nav-link {
            padding: 10px;
            color: #fff;
            font-weight: bold;
            text-decoration: none;
            display: block;
        }

        .navbar-light .navbar-toggler-icon {
            background-color: #fff;
        }

        /* Additional styles for displaying default product information */
        .product-box-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 20px;
            flex-direction: row; /* Set flex direction to row */
        }

        .product-box {
            width: 70%; /* Set width to 70% */
            height: 20%; /* Set height to 20% */
            margin: 10px; /* Adjusted margin */
            padding: 10px; /* Adjusted padding */
            border: 2px solid #3498db;
            border-radius: 10px;
            background-color: #ecf0f1; /* Different background color */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center; /* Center items vertically */
        }

        .product-box img {
            width: 30%; /* Set width of the image */
            height: 100%; /* Make image fill the container */
            border-radius: 10px;
        }

        .product-details {
            padding: 10px;
            width: 70%;
            box-sizing: border-box;
            text-align: left; /* Align text to the left */
        }

        .product-box h3 {
            font-size: 18px; /* Adjusted font size */
            margin-bottom: 10px;
            color: #2c3e50; /* Different font color */
        }
        
    </style>
</head>
<body>
    <div id="header">
        <h1>Welcome to Our Laptop Store</h1>
        <p>Explore a wide range of laptops for all your computing needs.</p>
    </div>

    <nav class="navbar navbar-expand-sm navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="laptopcategories.jsp">Laptop Categories</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="laptopbrands.jsp">Laptop Brands</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="laptopsearch.jsp">Search Laptops</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="shoppingcart.jsp">Shopping Cart</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="checkout.jsp">Checkout</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="useraccount.jsp">User Account</a>
            </li>
        </ul>
    </nav>
    
    <!-- Display default product information -->
    <div class="product-box-container">
        <% 
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from products");
                
                while (rs.next()) {
                    String imageName = rs.getString(5); // Assuming column 5 contains the image filename
                    String imagePath = "Images/" + imageName;
        %>
                    <div class="product-box">
                        <img src="<%=imagePath %>" alt="<%=rs.getString(2) %>">
                        <div class="product-details">
                            <h3><%=rs.getString(2) %></h3>
                            <p>Price: <%=rs.getInt(3) %></p>
                            <p>Quantity: <%=rs.getInt(4) %></p>
                        </div>
                    </div>
                <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                out.println(e);
            }
        %>
    </div>
   
</body>
</html>
