/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import com.google.gson.Gson;
import database.DatabaseHandler;
import database.Note;
import database.Notes;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class SearchNotes extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query=req.getParameter("query");
        int userId=Integer.parseInt(req.getParameter("userId"));
        ArrayList<Note> notes = new ArrayList<>();
        try {
            Connection conn = DatabaseHandler.getConn();
            ResultSet result = conn.createStatement().executeQuery("select Id, Title, Content from Notes where UserId=" 
                    + userId + " AND Title like '%"+query+"%' OR Content like '%"+query+"%' ORDER BY Id DESC;");
            while(result.next()){
                Note note=new Note(result.getInt("Id"),result.getString("Title"),result.getString("Content"));
                notes.add(note);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Notes.class.getName()).log(Level.SEVERE, null, ex);
        }

        String data = new Gson().toJson(notes);
        resp.getWriter().print(data);
    
    }
    
}
