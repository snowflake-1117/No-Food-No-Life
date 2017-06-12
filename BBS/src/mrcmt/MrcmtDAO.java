package mrcmt;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MrcmtDAO {
	private Connection conn;
	private ResultSet rs;
	
	public MrcmtDAO(){
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
		String SQL = "SELECT mrcmtID FROM MRCMT ORDER BY mrcmtID DESC";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1;//첫번째 댓글인 경우
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	
	public int write(String userID, String mrcmtContent, int rbsID){
		String SQL = "INSERT INTO MRCMT VALUES (?, ?, ?, ?, ?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, rbsID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, mrcmtContent);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	
	public ArrayList<Mrcmt> getList(int mrcmtPageNumber){
		String SQL = "SELECT * FROM MRCMT WHERE mrcmtID < ? ORDER BY mrcmtID";
		ArrayList<Mrcmt> list = new ArrayList<Mrcmt>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (mrcmtPageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Mrcmt mrcmt = new Mrcmt();
				mrcmt.setMrcmtID(rs.getInt(1));
				mrcmt.setUserID(rs.getString(2));
				mrcmt.setMrbsID(rs.getInt(3));
				mrcmt.setMrcmtDate(rs.getString(4));
				mrcmt.setMrcmtContent(rs.getString(5));
				list.add(mrcmt);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int mrcmtPageNumber){
		String SQL = "SELECT * FROM MRCMT WHERE mrcmtID < ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (mrcmtPageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public Mrcmt getMrcmt(int mrcmtID){
		String SQL = "SELECT * FROM MRCMT WHERE mrcmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  mrcmtID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Mrcmt mrcmt = new Mrcmt();
				mrcmt.setMrcmtID(rs.getInt(1));
				mrcmt.setUserID(rs.getString(2));
				mrcmt.setMrbsID(rs.getInt(3));
				mrcmt.setMrcmtDate(rs.getString(4));
				mrcmt.setMrcmtContent(rs.getString(5));
				return mrcmt;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public int update(String mrcmtContent, int mrcmtID){
		String SQL = "UPDATE MRCMT SET mrcmtContent = ? WHERE mrcmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, mrcmtContent);
			pstmt.setInt(2, mrcmtID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	
	public int delete(int mrcmtID){
		String SQL = "DELETE FROM MRCMT WHERE mrcmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mrcmtID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	
	public int deletePost(int rbsID){//게시글 삭제시 댓글도 함께 삭제
		String SQL = "DELETE FROM MRCMT WHERE rbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	

	public void reSort(int rbsID) {// 테이블 rbsID 재정렬
		try {
			String SQL = "UPDATE MRCMT SET rbsID = rbsID -1 WHERE rbsID > ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int countMrcmt(int mrbsID) {//테이블의 총 row 개수를 리턴
		int total_count = 0;
		String SQL = "select count(mrbsID) count from MRCMT WHERE mrbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mrbsID);
			rs = pstmt.executeQuery();
			rs.next();
			return total_count = rs.getInt("count");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
