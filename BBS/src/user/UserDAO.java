package user;

import java.sql.DriverManager;
import java.sql.ResultSet;

import user.User;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO(){
		try{
			String dbURL = "jdbc:mysql://localhost:3306/BBS?autoReconnect=true&useSSL=false";
			String dbID = "root";
			String dbPassword="1653";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	

	public int update(String userPassword, String userEmail, String userID){
		String SQL = "UPDATE USER SET userPassword=?, userEmail=? WHERE userID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public User getUser(String userID){
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				return user;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int login(String userID, String userPassword){
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString(1).equals(userPassword)){
					return 1;//success to login
				}
				else return 0;//password unequal
			}
			return -1;//no ID
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;//database error
	}
	
	public int join(User user){
		String SQL = "INSERT INTO USER VALUES (?,?,?,?)";
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			return pstmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
}
