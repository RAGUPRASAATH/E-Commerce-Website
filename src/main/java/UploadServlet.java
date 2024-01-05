import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.PrintWriter;
import java.io.StringWriter;

//... (imports)

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
     Connection con = null; // Declare con outside the try block

     try {
         String productId = request.getParameter("p1");
         String productName = request.getParameter("p2");
         String price = request.getParameter("p3");
         String quantity = request.getParameter("q1");

         Part filePart = request.getPart("file");
         String imageName = getFileName(filePart);

         String customUploadPath = "D:\\JavaFolder\\EcommerceProject\\src\\main\\webapp\\WEB-INF\\Images";
         Path uploadPath = Paths.get(customUploadPath);

         if (!Files.exists(uploadPath)) {
             try {
                 Files.createDirectories(uploadPath);
             } catch (IOException e) {
                 e.printStackTrace();
                 response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create upload directory.");
                 return;
             }
         }

         try (InputStream input = filePart.getInputStream()) {
             Path filePath = uploadPath.resolve(imageName);
             Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
         } catch (IOException e) {
             e.printStackTrace();
             response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to upload file.");
             return;
         }

         Class.forName("com.mysql.cj.jdbc.Driver");
         con = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminstoragedata", "root", "Prasaath2001");

         con.setAutoCommit(false); // Start a transaction

         String sql = "INSERT INTO products (productId, productName, price, quantity, imageName) VALUES (?, ?, ?, ?, ?)";
         try (PreparedStatement pt = con.prepareStatement(sql)) {
             pt.setString(1, productId);
             pt.setString(2, productName);
             pt.setString(3, price);
             pt.setString(4, quantity);
             pt.setString(5, imageName);

             int rowsAffected = pt.executeUpdate();

             if (rowsAffected > 0) {
                 con.commit(); // Commit the transaction
              // Set a success message as an attribute in the request
                 request.setAttribute("successMessage", "Insert successfully");
                 // Forward the request to the productadd.jsp page
                 request.getRequestDispatcher("productadd.jsp").forward(request, response);
             } else {
                 con.rollback(); // Rollback the transaction if no rows were affected
                 response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to insert data into the database.");
             }
         }
     }  catch (SQLException | ClassNotFoundException e) {
    	    e.printStackTrace();
    	    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to save data to the database. Error: " + e.getMessage());

    	    // Additional debugging information
    	    StringWriter sw = new StringWriter();
    	    PrintWriter pw = new PrintWriter(sw);
    	    e.printStackTrace(pw);
    	    String exceptionDetails = sw.toString();
    	    System.out.println("Exception details: " + exceptionDetails);
     } finally {
         try {
             if (con != null) {
                 con.setAutoCommit(true); // Restore auto-commit mode
                 con.close();
             }
         } catch (SQLException e) {
             e.printStackTrace();
         }
     }
 }

 private String getFileName(final Part part) {
     final String partHeader = part.getHeader("content-disposition");
     for (String content : partHeader.split(";")) {
         if (content.trim().startsWith("filename")) {
             return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
         }
     }
     return null;
 }
}
