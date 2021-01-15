package servlets;

import database.DatabaseHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
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
public class LoginHandler extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String emailId=(String) req.getParameter("emailId");
        String password=(String) req.getParameter("password");
        int userId=checkLogin(emailId, password);
        if(userId>-1){
            resp.addCookie(new Cookie("userId",""+userId));
            resp.sendRedirect("index.jsp");
        }else{
            HttpSession s= req.getSession();
            s.setAttribute("error", "Invalid EmailId or Password");
            resp.sendRedirect("Pages/Login.jsp");
        }
    }
    
    public int checkLogin(String emailId,String password){
        try {
            ResultSet result= DatabaseHandler.getConn()
                    .createStatement()
                    .executeQuery("select ud.UserId from UserDetails"
                            + " as ud inner join LoginDetails as ld on ud.UserId=ld.UserId "
                            + "where ud.EmailId='"+emailId+"' and ld.Password='"+password+"';");
            while(result.next()){
                return result.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
}
