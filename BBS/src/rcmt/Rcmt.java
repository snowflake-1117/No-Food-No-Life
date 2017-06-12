package rcmt;

import java.sql.Date;

public class Rcmt {
	private int rcmtID;
	private String userID;
	private int rbsID;
	private String rcmtDate;
	private String rcmtContent;
	public int getRcmtID() {
		return rcmtID;
	}
	public void setRcmtID(int rcmtID) {
		this.rcmtID = rcmtID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getRbsID() {
		return rbsID;
	}
	public void setRbsID(int rbsID) {
		this.rbsID = rbsID;
	}
	public String getRcmtDate() {
		return rcmtDate;
	}
	public void setRcmtDate(String rcmtDate) {
		this.rcmtDate = rcmtDate;
	}
	public String getRcmtContent() {
		return rcmtContent;
	}
	public void setRcmtContent(String rcmtContent) {
		this.rcmtContent = rcmtContent;
	}
}
