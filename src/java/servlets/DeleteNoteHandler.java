/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import database.DatabaseHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Meghanath Nalawade
 */
public class DeleteNoteHandler extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        PreparedStatement stmt;
        Connection conn = DatabaseHandler.getConn();
        try {
            stmt = conn.prepareStatement("delete from Notes where Id=?");
            stmt.setInt(1, id);
            if (stmt.executeUpdate() == 1) {
                resp.getWriter().print("true");
                return;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        resp.getWriter().print("false");

    }

}
