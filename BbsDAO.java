package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO(){
		try{
			String dbURL = "jdbc:mysql://localhost:3306/BBS?autoReconnect=true&useSSL=false";
			String dbID = "root";
			String dbPassword="123456";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public String getDate(){
		String SQL = "SELECT NOW()";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()){
				return rs.getString(1);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext(){
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1;
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int like(int bbsID){
		String SQL = "UPDATE BBS SET bbsLike = bbsLike+1 WHERE bbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public int write(String bbsCategory, String bbsTitle, String userID, String bbsContent, String bbsVideoSrc, String bbsImage){
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsCategory);
			pstmt.setString(3, bbsTitle);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, bbsContent);
			pstmt.setInt(7, 1);
			pstmt.setInt(8, 0);
			pstmt.setString(9, bbsVideoSrc);
			pstmt.setInt(10, 0);
			pstmt.setString(11, bbsImage);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public void hit(int bbsID){
		String SQL = "UPDATE BBS SET bbsHit = bbsHit+1 WHERE bbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsCategory(rs.getString(2));
				bbs.setBbsTitle(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				bbs.setBbsHit(rs.getInt(8));
				bbs.setBbsVideoSrc(rs.getString(9));
				bbs.setBbsLike(rs.getInt(10));
				bbs.setBbsImage(rs.getString(11));
				list.add(bbs);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> searchList(int pageNumber, String searchOption, String searchInput){
		String SQL = "SELECT * FROM BBS WHERE "+searchOption+" LIKE ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setString(1, searchOption);
			pstmt.setString(1, "%"+searchInput+"%");
			//pstmt.setInt(1,  getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsCategory(rs.getString(2));
				bbs.setBbsTitle(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				bbs.setBbsHit(rs.getInt(8));
				bbs.setBbsVideoSrc(rs.getString(9));
				bbs.setBbsLike(rs.getInt(10));
				bbs.setBbsImage(rs.getString(11));
				list.add(bbs);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}	
	
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID){
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsCategory(rs.getString(2));
				bbs.setBbsTitle(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				bbs.setBbsHit(rs.getInt(8));
				bbs.setBbsVideoSrc(rs.getString(9));
				bbs.setBbsLike(rs.getInt(10));
				bbs.setBbsImage(rs.getString(11));
				return bbs;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsCategory, String bbsTitle, String bbsContent, String bbsVideoSrc, String bbsImage){
		String SQL = "UPDATE BBS SET bbsCategory = ?, bbsTitle = ?, bbsContent = ?, bbsVideoSrc = ?, bbsImage = ? WHERE bbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsCategory);
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, bbsContent);
			pstmt.setString(4, bbsVideoSrc);
			pstmt.setString(5, bbsImage);
			pstmt.setInt(6, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID){
		String SQL = "DELETE FROM BBS WHERE bbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public void reSort(int count) {
		while (count <= maxCount()) {
			try {
				String SQL = "UPDATE BBS SET bbsID = bbsID -1 WHERE bbsID > ?";
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, count++);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public int maxCount() {
		int total_count = 0;
		String SQL = "select count(*) count from BBS";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			rs.next();
			return total_count = rs.getInt("count");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}