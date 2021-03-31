package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
			String dbID = "scott";
			String dbPassword = "tiger";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e){
			e.printStackTrace();
			
		}
	}
	
	public ArrayList<User> search(String userName){
		String SQL ="select * from address1 where userName LIKE '?%'";
		ArrayList<User> userList = new ArrayList<User>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,"%"+ userName + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserName(rs.getString("1"));
				user.setUserLat(rs.getFloat("2"));
				user.setUserLng(rs.getFloat("3"));
				userList.add(user);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return userList;
	}
	
}
