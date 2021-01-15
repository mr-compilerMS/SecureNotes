package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Meghanath Nalawade
 */
public class DatabaseHandler {

    static Connection conn;

    public static Connection getConn() {
        try {
            if (conn != null) {
                if (!conn.isClosed()) {
                    return conn;
                }

            }

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Notes", "root", "ms");

            return conn;
        } catch (Exception ex) {
            Logger.getLogger(DatabaseHandler.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

}
