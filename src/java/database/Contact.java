package database;

/**
 *
 * @author Meghanath Nalawade
 */
public class Contact {

    int id,userId;
    String name,phoneNo,emailId;

    public Contact(int id, int userId, String name, String phoneNo, String emailId) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.phoneNo = phoneNo;
        this.emailId = emailId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }
    
    
}
