package mrbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mrbs.Mrbs;

public class MrbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public MrbsDAO(){
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public int getNext() {
		String SQL = "SELECT mrbsID FROM MRBS ORDER BY mrbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;// 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 디비 오류
	}

	public int write(String mrbsCategory, String mrbsTitle, String userID, String mrbsContent, String mrbsVideoSrc,
			String mrbsImage) {
		String SQL = "INSERT INTO MRBS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, mrbsCategory);
			pstmt.setString(3, mrbsTitle);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, mrbsContent);
			pstmt.setInt(7, 1);
			pstmt.setInt(8, 0);
			pstmt.setString(9, mrbsVideoSrc);
			pstmt.setInt(10, 0);
			pstmt.setString(11, mrbsImage);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 디비 오류
	}

	public void hit(int mrbsID) {
		String SQL = "UPDATE MRBS SET mrbsHit = mrbsHit+1 WHERE mrbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mrbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Mrbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM MRBS WHERE mrbsID < ? ORDER BY mrbsID DESC LIMIT 10";
		ArrayList<Mrbs> list = new ArrayList<Mrbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Mrbs mrbs = new Mrbs();
				mrbs.setMrbsID(rs.getInt(1));
				mrbs.setMrbsCategory(rs.getString(2));
				mrbs.setMrbsTitle(rs.getString(3));
				mrbs.setUserID(rs.getString(4));
				mrbs.setMrbsDate(rs.getString(5));
				mrbs.setMrbsContent(rs.getString(6));
				mrbs.setMrbsAvailable(rs.getInt(7));
				mrbs.setMrbsHit(rs.getInt(8));
				mrbs.setMrbsVideoSrc(rs.getString(9));
				mrbs.setMrbsLike(rs.getInt(10));
				mrbs.setMrbsImage(rs.getString(11));
				list.add(mrbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Mrbs> getCategoryList(String mrbsCategory) {
		String SQL = "SELECT * FROM MRBS WHERE mrbsCategory = ? ORDER BY mrbsID DESC";
		ArrayList<Mrbs> list = new ArrayList<Mrbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, mrbsCategory);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Mrbs mrbs = new Mrbs();
				mrbs.setMrbsID(rs.getInt(1));
				mrbs.setMrbsCategory(rs.getString(2));
				mrbs.setMrbsTitle(rs.getString(3));
				mrbs.setUserID(rs.getString(4));
				mrbs.setMrbsDate(rs.getString(5));
				mrbs.setMrbsContent(rs.getString(6));
				mrbs.setMrbsAvailable(rs.getInt(7));
				mrbs.setMrbsHit(rs.getInt(8));
				mrbs.setMrbsVideoSrc(rs.getString(9));
				mrbs.setMrbsImage(rs.getString(10));
				list.add(mrbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM MRBS WHERE mrbsID < ? AND mrbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next())
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public Mrbs getMrbs(int mrbsID) {
		String SQL = "SELECT * FROM MRBS WHERE mrbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mrbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Mrbs mrbs = new Mrbs();
				mrbs.setMrbsID(rs.getInt(1));
				mrbs.setMrbsCategory(rs.getString(2));
				mrbs.setMrbsTitle(rs.getString(3));
				mrbs.setUserID(rs.getString(4));
				mrbs.setMrbsDate(rs.getString(5));
				mrbs.setMrbsContent(rs.getString(6));
				mrbs.setMrbsAvailable(rs.getInt(7));
				mrbs.setMrbsHit(rs.getInt(8));
				mrbs.setMrbsVideoSrc(rs.getString(9));
				mrbs.setMrbsLike(rs.getInt(10));
				mrbs.setMrbsImage(rs.getString(11));
				return mrbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(int mrbsID, String mrbsCategory, String mrbsTitle, String mrbsContent, String mrbsVideoSrc,
			String mrbsImage) {
		String SQL = "UPDATE MRBS SET mrbsCategory = ?, mrbsTitle = ?, mrbsContent = ?, mrbsVideoSrc = ?, mrbsImage = ? WHERE mrbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, mrbsCategory);
			pstmt.setString(2, mrbsTitle);
			pstmt.setString(3, mrbsContent);
			pstmt.setString(4, mrbsVideoSrc);
			pstmt.setString(5, mrbsImage);
			pstmt.setInt(6, mrbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 디비 오류
	}

	public int delete(int mrbsID) {
		String SQL = "DELETE FROM MRBS WHERE mrbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mrbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 디비 오류
	}

	public void reSort(int mrbsID) {// 테이블 mrbsID 재정렬
		try {
			String SQL = "UPDATE MRBS SET mrbsID = mrbsID -1 WHERE mrbsID > ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mrbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int like(int mrbsID){
		String SQL = "UPDATE MRBS SET mrbsLike = mrbsLike+1 WHERE mrbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  mrbsID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}


}