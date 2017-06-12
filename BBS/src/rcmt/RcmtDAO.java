package rcmt;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RcmtDAO {
	private Connection conn;
	private ResultSet rs;
	
	public RcmtDAO(){
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
		String SQL = "SELECT rcmtID FROM RCMT ORDER BY rcmtID DESC";
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
	
	public int write(String userID, String rcmtContent, int rbsID){
		String SQL = "INSERT INTO RCMT VALUES (?, ?, ?, ?, ?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, rbsID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, rcmtContent);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	
	public ArrayList<Rcmt> getList(int rcmtPageNumber){
		String SQL = "SELECT * FROM RCMT WHERE rcmtID < ? ORDER BY rcmtID";
		ArrayList<Rcmt> list = new ArrayList<Rcmt>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (rcmtPageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Rcmt rcmt = new Rcmt();
				rcmt.setRcmtID(rs.getInt(1));
				rcmt.setUserID(rs.getString(2));
				rcmt.setRbsID(rs.getInt(3));
				rcmt.setRcmtDate(rs.getString(4));
				rcmt.setRcmtContent(rs.getString(5));
				list.add(rcmt);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int rcmtPageNumber){
		String SQL = "SELECT * FROM RCMT WHERE rcmtID < ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (rcmtPageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public Rcmt getRcmt(int rcmtID){
		String SQL = "SELECT * FROM RCMT WHERE rcmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  rcmtID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Rcmt rcmt = new Rcmt();
				rcmt.setRcmtID(rs.getInt(1));
				rcmt.setUserID(rs.getString(2));
				rcmt.setRbsID(rs.getInt(3));
				rcmt.setRcmtDate(rs.getString(4));
				rcmt.setRcmtContent(rs.getString(5));
				return rcmt;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public int update(String rcmtContent, int rcmtID){
		String SQL = "UPDATE RCMT SET rcmtContent = ? WHERE rcmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rcmtContent);
			pstmt.setInt(2, rcmtID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	
	public int delete(int rcmtID){
		String SQL = "DELETE FROM RCMT WHERE rcmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rcmtID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//디비 오류
	}
	
	public int deletePost(int rbsID){//게시글 삭제시 댓글도 함께 삭제
		String SQL = "DELETE FROM RCMT WHERE rbsID = ?";
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
			String SQL = "UPDATE RCMT SET rbsID = rbsID -1 WHERE rbsID > ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int countRcmt(int rbsID) {//테이블의 총 row 개수를 리턴
		int total_count = 0;
		String SQL = "select count(rbsID) count from RCMT WHERE rbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rbsID);
			rs = pstmt.executeQuery();
			rs.next();
			return total_count = rs.getInt("count");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
