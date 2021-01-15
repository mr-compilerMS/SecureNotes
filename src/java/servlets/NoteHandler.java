/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import com.google.gson.Gson;
import database.DatabaseHandler;
import database.Note;
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

/**
 *
 * @author Meghanath Nalawade
 */
public class NoteHandler extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        resp.setStatus(resp.SC_OK);
        try {
            Connection conn = DatabaseHandler.getConn();
            ResultSet result = conn.createStatement().executeQuery("select Id, Title, Content from Notes where Id=" + id + ";");
            while (result.next()) {
                Note note = new Note(result.getInt("Id"), result.getString("Title"), result.getString("Content"));
                String data = new Gson().toJson(note);
                resp.getWriter().print(data);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NoteHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("editId") != null) {
            String title = req.getParameter("editTitle");
            String content = req.getParameter("editContent");
            int id = Integer.parseInt(req.getParameter("editId"));
            resp.getWriter().print(updateNote(id, title, content));
            return;
        }

        String title = req.getParameter("title");
        String content = req.getParameter("content");
        int userId = 0;
        for (Cookie cookie : req.getCookies()) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        resp.getWriter().print(saveNote(title, content, userId));
        resp.setStatus(resp.SC_OK);

    }

    private boolean saveNote(String title, String content, int userId) {
        PreparedStatement stmt;
        Connection conn = DatabaseHandler.getConn();
        try {
            stmt = conn.prepareStatement("insert into Notes(Title, Content, UserId) values(?,?,?)");
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setInt(3, userId);
            if (stmt.executeUpdate() == 1) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private boolean updateNote(int id, String title, String content) {
        PreparedStatement stmt;
        Connection conn = DatabaseHandler.getConn();
        try {
            stmt = conn.prepareStatement("update Notes set Title = ? , Content=? where Id = ?;");
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setInt(3, id);
            if (stmt.executeUpdate() == 1) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }


}
