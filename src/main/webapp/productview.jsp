<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Product View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: 'Verdana', sans-serif;
            background: linear-gradient(to right, #3498db, #2ecc71);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
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

        .container {
        text-align: center;
        margin-top: 50px; /* Adjust the margin to move it below the navigation bar */
        width: 35%; /* Set the width of the container */
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
        .load {
    margin-top: 20px; /* Adjust the top margin based on your layout */
}

.b1 {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px; /* Adjust the top margin inside .load based on your layout */
}

.b1 td, .b1 th {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.b1 th {
    background-color: #f2f2f2;
}

/* Additional styles for table rows */
.b1 tr:nth-child(even) {
    background-color: #f9f9f9;
}

.b1 tr:hover {
    background-color: #f5f5f5;
}

/* Styles for images inside the table */
.b1 img {
    max-width: 100%;
    height: auto;
    border-radius: 5px; /* Add rounded corners to the images */
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
   <div class="container">
	      <form action="#" method="post">
		       <table>
					<tr>
						<td><input  class="s2"type="text" name="p1" placeholder="Search Product.."></td>
						<td class="s1"><input type="submit" value="Search" ></td>
					</tr>
					
				</table>
		
			 <% 
            String a = request.getParameter("p1");
            if (a != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("select * from products where productId like '" + a + "%'");
                    
                    while (rs.next()) {
                    	String imageName = rs.getString(5); // Assuming column 5 contains the image filename
                    	String imagePath = "Images/" + imageName;

        %>
                        <div class="load">
                            <table class="b1">
                                <tr>
                                    <td>Product Id</td>
                                    <td>Product Name</td>
                                    <td>Price</td>
                                    <td>Quantity</td>
                                    <td>Image</td>
                                </tr>
                                <tr>
                                    <td><%=rs.getInt(1) %></td>
                                    <td><%=rs.getString(2) %></td>
                                    <td><%=rs.getInt(3) %></td>
                                    <td><%=rs.getInt(4) %></td>
                                     <td><img src="<%=imagePath %>"  width="200px" height="200px"></td>
                                </tr>
                            </table>
                        </div>
                    <%
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    out.println(e);
                }
            }
        %>
        	</form>
	</div>
</body>
</html>
