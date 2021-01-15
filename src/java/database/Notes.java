package database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Meghanath Nalawade
 */
public class Notes {

    public ArrayList<Note> getNotes(int userId) {
        ArrayList<Note> notes = new ArrayList<>();
        try {
            Connection conn = DatabaseHandler.getConn();
            ResultSet result = conn.createStatement().executeQuery("select Id, Title, Content from Notes where UserId=" + userId + " ORDER BY Id DESC;");
            while(result.next()){
                Note note=new Note(result.getInt("Id"),result.getString("Title"),result.getString("Content"));
                notes.add(note);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Notes.class.getName()).log(Level.SEVERE, null, ex);
        }

        return notes;
    }
}

