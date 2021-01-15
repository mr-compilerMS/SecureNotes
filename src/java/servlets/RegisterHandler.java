package servlets;

import database.DatabaseHandler;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Meghanath Nalawade
 */
public class RegisterHandler extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String fName = (String) req.getParameter("fname");
        String lName = (String) req.getParameter("lname");
        String emailId = (String) req.getParameter("emailId");
        String password = (String) req.getParameter("password");
        if (!checkUserExists(emailId)) {
            int userId = registerUser(fName, lName, emailId, password);
            if (userId > -1) {
                resp.addCookie(new Cookie("userId", "" + userId));
                resp.sendRedirect("index.jsp");
            } else {
                HttpSession s = req.getSession();
                s.setAttribute("error", "Unable To register please try after sometime");
                resp.sendRedirect("Pages/Login.jsp");
            }
        } else {
            HttpSession s = req.getSession();
            s.setAttribute("error", "User already exists..");
            resp.sendRedirect("Pages/Login.jsp");
        }
    }

    public boolean checkUserExists(String emailId) {
        try {
            ResultSet result = DatabaseHandler.getConn()
                    .createStatement()
                    .executeQuery("select UserId from UserDetails where EmailId='"+emailId+"';");
            while (result.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private int registerUser(String fName, String lName, String emailId, String password) {
        PreparedStatement stmt;
        Connection conn = DatabaseHandler.getConn();
        try {
            stmt = conn.prepareStatement("insert into UserDetails(FirstName, LastName ,EmailId) values(?,?,?)");
            stmt.setString(1, fName);
            stmt.setString(2, lName);
            stmt.setString(3, emailId);
            if (stmt.executeUpdate() == 1) {
                ResultSet result = conn.createStatement()
                        .executeQuery("select UserId from UserDetails where EmailId='"+emailId+"';");
                result.first();
                int userId = result.getInt("UserId");
                stmt = conn.prepareStatement("insert into LoginDetails(UserId, Password) values(" + userId + ",'" + password + "');");
                if (stmt.executeUpdate() == 1) {
                    return userId;
                } else {
                    return -1;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
}
