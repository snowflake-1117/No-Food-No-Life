package nbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NbsDAO {
	private Connection conn;
	private ResultSet rs;

	public NbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?autoReconnect=true&useSSL=false";
			String dbID = "root";
			String dbPassword = "1653";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
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
		String SQL = "SELECT nbsID FROM NBS ORDER BY nbsID DESC";
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

	public int write(String nbsTitle, String userID, String nbsContent, String nbsImage) {
		String SQL = "INSERT INTO NBS VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, nbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, nbsContent);
			pstmt.setInt(6, 0);
			pstmt.setString(7, nbsImage);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 디비 오류
	}

	public void hit(int nbsID) {
		String SQL = "UPDATE NBS SET nbsHit = nbsHit+1 WHERE nbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Nbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM NBS WHERE nbsID < ? ORDER BY nbsID DESC LIMIT 10";
		ArrayList<Nbs> list = new ArrayList<Nbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Nbs nbs = new Nbs();
				nbs.setNbsID(rs.getInt(1));
				nbs.setNbsTitle(rs.getString(2));
				nbs.setUserID(rs.getString(3));
				nbs.setNbsDate(rs.getString(4));
				nbs.setNbsContent(rs.getString(5));
				nbs.setNbsHit(rs.getInt(6));
				nbs.setNbsImage(rs.getString(7));
				list.add(nbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM NBS WHERE nbsID < ?";
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

	public Nbs getNbs(int nbsID) {
		String SQL = "SELECT * FROM NBS WHERE nbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Nbs nbs = new Nbs();
				nbs.setNbsID(rs.getInt(1));
				nbs.setNbsTitle(rs.getString(2));
				nbs.setUserID(rs.getString(3));
				nbs.setNbsDate(rs.getString(4));
				nbs.setNbsContent(rs.getString(5));
				nbs.setNbsHit(rs.getInt(6));
				nbs.setNbsImage(rs.getString(7));
				return nbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(int nbsID, String nbsTitle, String nbsContent, String nbsImage) {
		String SQL = "UPDATE NBS SET nbsTitle = ?, nbsContent = ?, nbsImage = ? WHERE nbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, nbsTitle);
			pstmt.setString(2, nbsContent);
			pstmt.setString(3, nbsImage);
			pstmt.setInt(4, nbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 디비 오류
	}

	public int delete(int nbsID) {
		String SQL = "DELETE FROM NBS WHERE nbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 디비 오류
	}

	public void reSort(int nbsID) {// 테이블 nbsID 재정렬
		try {
			String SQL = "UPDATE NBS SET nbsID = nbsID -1 WHERE nbsID > ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * public int maxCount() {// 테이블의 총 row 개수를 리턴 int total_count = 0; String
	 * SQL = "select count(*) count from nbs"; try { PreparedStatement pstmt =
	 * conn.prepareStatement(SQL); rs = pstmt.executeQuery(); rs.next(); return
	 * total_count = rs.getInt("count"); } catch (Exception e) {
	 * e.printStackTrace(); } return -1; }
	 */

}