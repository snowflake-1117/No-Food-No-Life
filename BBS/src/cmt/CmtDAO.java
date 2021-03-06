package cmt;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CmtDAO {
	private Connection conn;
	private ResultSet rs;
	
	public CmtDAO(){
		try{
			String dbURL = "jdbc:mysql://localhost:3307/BBS?autoReconnect=true&useSSL=false";
			String dbID = "root";
			String dbPassword="websys";
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
		String SQL = "SELECT cmtID FROM CMT ORDER BY cmtID DESC";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1;//泥ル쾲吏� �뙎湲��씤 寃쎌슦
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//�뵒鍮� �삤瑜�
	}
	
	public int write(String userID, String cmtContent, int bbsID){
		String SQL = "INSERT INTO CMT VALUES (?, ?, ?, ?, ?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, bbsID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, cmtContent);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//�뵒鍮� �삤瑜�
	}
	
	public ArrayList<Cmt> getList(int cmtPageNumber){
		String SQL = "SELECT * FROM CMT WHERE cmtID < ? ORDER BY cmtID";
		ArrayList<Cmt> list = new ArrayList<Cmt>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (cmtPageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Cmt cmt = new Cmt();
				cmt.setCmtID(rs.getInt(1));
				cmt.setUserID(rs.getString(2));
				cmt.setBbsID(rs.getInt(3));
				cmt.setCmtDate(rs.getString(4));
				cmt.setCmtContent(rs.getString(5));
				list.add(cmt);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int cmtPageNumber){
		String SQL = "SELECT * FROM CMT WHERE cmtID < ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (cmtPageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public Cmt getCmt(int cmtID){
		String SQL = "SELECT * FROM CMT WHERE cmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  cmtID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Cmt cmt = new Cmt();
				cmt.setCmtID(rs.getInt(1));
				cmt.setUserID(rs.getString(2));
				cmt.setBbsID(rs.getInt(3));
				cmt.setCmtDate(rs.getString(4));
				cmt.setCmtContent(rs.getString(5));
				return cmt;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public int update(String cmtContent, int cmtID){
		String SQL = "UPDATE CMT SET cmtContent = ? WHERE cmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cmtContent);
			pstmt.setInt(2, cmtID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//�뵒鍮� �삤瑜�
	}
	
	public int delete(int cmtID){
		String SQL = "DELETE FROM CMT WHERE cmtID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//�뵒鍮� �삤瑜�
	}
	
	public int deletePost(int bbsID){//寃뚯떆湲� �궘�젣�떆 �뙎湲��룄 �븿猿� �궘�젣
		String SQL = "DELETE FROM CMT WHERE bbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1;//�뵒鍮� �삤瑜�
	}
	

	public void reSort(int bbsID) {// �뀒�씠釉� bbsID �옱�젙�젹
		try {
			String SQL = "UPDATE CMT SET bbsID = bbsID -1 WHERE bbsID > ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int countCmt(int bbsID) {//�뀒�씠釉붿쓽 珥� row 媛쒖닔瑜� 由ы꽩
		int total_count = 0;
		String SQL = "select count(bbsID) count from CMT WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			rs.next();
			return total_count = rs.getInt("count");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
