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
public class Contacts {

    public ArrayList<Contact> getContacts(int userId) {
        ArrayList<Contact> contacts = new ArrayList<>();
        try {
            Connection conn = DatabaseHandler.getConn();
            ResultSet result = conn.createStatement().executeQuery("select Id, Name, MobileNo, EmailId  from Notes where UserId=" + userId + " ORDER BY Name ASC;");
            while(result.next()){
                Contact contact=new Contact(result.getInt("Id"),userId,result.getString("Name"),result.getString("MobileNo"),result.getString("EmailId"));
                contacts.add(contact);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Notes.class.getName()).log(Level.SEVERE, null, ex);
        }

        return contacts;
    }
}

