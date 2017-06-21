package rbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RbsDAO {
	private Connection conn;
	private ResultSet rs;

	public RbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3307/BBS?autoReconnect=true&useSSL=false";
			String dbID = "root";
			String dbPassword = "websys";
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
		String SQL = "SELECT rbsID FROM RBS ORDER BY rbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;// 泥ル쾲吏� 寃뚯떆臾쇱씤 寃쎌슦
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// �뵒鍮� �삤瑜�
	}

	public int write(String rbsCategory, String rbsTitle, String userID, String rbsContent, String rbsVideoSrc,
			String rbsImage) {
		String SQL = "INSERT INTO RBS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, rbsCategory);
			pstmt.setString(3, rbsTitle);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, rbsContent);
			pstmt.setInt(7, 1);
			pstmt.setInt(8, 0);
			pstmt.setString(9, rbsVideoSrc);
			pstmt.setString(10, rbsImage);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// �뵒鍮� �삤瑜�
	}

	public void hit(int rbsID) {
		String SQL = "UPDATE RBS SET rbsHit = rbsHit+1 WHERE rbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Rbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM RBS WHERE rbsID < ? ORDER BY rbsID DESC LIMIT 10";
		ArrayList<Rbs> list = new ArrayList<Rbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Rbs rbs = new Rbs();
				rbs.setRbsID(rs.getInt(1));
				rbs.setRbsCategory(rs.getString(2));
				rbs.setRbsTitle(rs.getString(3));
				rbs.setUserID(rs.getString(4));
				rbs.setRbsDate(rs.getString(5));
				rbs.setRbsContent(rs.getString(6));
				rbs.setRbsAvailable(rs.getInt(7));
				rbs.setRbsHit(rs.getInt(8));
				rbs.setRbsVideoSrc(rs.getString(9));
				rbs.setRbsImage(rs.getString(10));
				list.add(rbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Rbs> getCategoryList(String rbsCategory) {
		String SQL = "SELECT * FROM RBS WHERE rbsCategory = ? ORDER BY rbsID DESC";
		ArrayList<Rbs> list = new ArrayList<Rbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rbsCategory);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Rbs rbs = new Rbs();
				rbs.setRbsID(rs.getInt(1));
				rbs.setRbsCategory(rs.getString(2));
				rbs.setRbsTitle(rs.getString(3));
				rbs.setUserID(rs.getString(4));
				rbs.setRbsDate(rs.getString(5));
				rbs.setRbsContent(rs.getString(6));
				rbs.setRbsAvailable(rs.getInt(7));
				rbs.setRbsHit(rs.getInt(8));
				rbs.setRbsVideoSrc(rs.getString(9));
				rbs.setRbsImage(rs.getString(10));
				list.add(rbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM RBS WHERE rbsID < ? AND rbsAvailable = 1";
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

	public Rbs getRbs(int rbsID) {
		String SQL = "SELECT * FROM RBS WHERE rbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Rbs rbs = new Rbs();
				rbs.setRbsID(rs.getInt(1));
				rbs.setRbsCategory(rs.getString(2));
				rbs.setRbsTitle(rs.getString(3));
				rbs.setUserID(rs.getString(4));
				rbs.setRbsDate(rs.getString(5));
				rbs.setRbsContent(rs.getString(6));
				rbs.setRbsAvailable(rs.getInt(7));
				rbs.setRbsHit(rs.getInt(8));
				rbs.setRbsVideoSrc(rs.getString(9));
				rbs.setRbsImage(rs.getString(10));
				return rbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(int rbsID, String rbsCategory, String rbsTitle, String rbsContent, String rbsVideoSrc,
			String rbsImage) {
		String SQL = "UPDATE RBS SET rbsCategory = ?, rbsTitle = ?, rbsContent = ?, rbsVideoSrc = ?, rbsImage = ? WHERE rbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rbsCategory);
			pstmt.setString(2, rbsTitle);
			pstmt.setString(3, rbsContent);
			pstmt.setString(4, rbsVideoSrc);
			pstmt.setString(5, rbsImage);
			pstmt.setInt(6, rbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// �뵒鍮� �삤瑜�
	}

	public int delete(int rbsID) {
		String SQL = "DELETE FROM RBS WHERE rbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// �뵒鍮� �삤瑜�
	}

	public void reSort(int rbsID) {// �뀒�씠釉� rbsID �옱�젙�젹
		try {
			String SQL = "UPDATE RBS SET rbsID = rbsID -1 WHERE rbsID > ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*public int maxCount() {// �뀒�씠釉붿쓽 珥� row 媛쒖닔瑜� 由ы꽩
		int total_count = 0;
		String SQL = "select count(*) count from rbs";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			rs.next();
			return total_count = rs.getInt("count");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}*/

}