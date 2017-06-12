package mrcmt;

import java.sql.Date;

public class Mrcmt {
	private int mrcmtID;
	private String userID;
	private int mrbsID;
	private String mrcmtDate;
	private String mrcmtContent;
	public int getMrcmtID() {
		return mrcmtID;
	}
	public void setMrcmtID(int mrcmtID) {
		this.mrcmtID = mrcmtID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getMrbsID() {
		return mrbsID;
	}
	public void setMrbsID(int mrbsID) {
		this.mrbsID = mrbsID;
	}
	public String getMrcmtDate() {
		return mrcmtDate;
	}
	public void setMrcmtDate(String mrcmtDate) {
		this.mrcmtDate = mrcmtDate;
	}
	public String getMrcmtContent() {
		return mrcmtContent;
	}
	public void setMrcmtContent(String mrcmtContent) {
		this.mrcmtContent = mrcmtContent;
	}
}