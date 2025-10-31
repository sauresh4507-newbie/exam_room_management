package com;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Database Connection Manager
 * @author PARAN
 */
public class Connect {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/esas?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1234";
    
    public static Connection connection;
    public static PreparedStatement pstmt;
    public static Statement statement;
    public static ResultSet rs;
    
    public Connect() {
    }
    
    public static void connect_mysql() {
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("✓ Database connection successful!");
        } catch (Exception e) {
            System.out.println("✗ Database connection failed!");
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public static String getOptionList(String tableName, String idColumn, String nameColumn, String orderBy, int selectedID, String unused) {
        StringBuilder result = new StringBuilder();
        
        // Null check for connection
        if (connection == null) {
            System.out.println("✗ Error: Database connection is null!");
            connect_mysql();
            if (connection == null) {
                return "";
            }
        }
        
        try {
            String sql = "SELECT " + idColumn + ", " + nameColumn + " FROM " + tableName;
            if (orderBy != null && !orderBy.isEmpty()) {
                sql += " ORDER BY " + orderBy;
            }
            
            pstmt = connection.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt(idColumn);
                String name = rs.getString(nameColumn);
                String selected = (id == selectedID) ? " selected" : "";
                result.append("<option value='").append(id).append("'").append(selected).append(">")
                      .append(name).append("</option>");
            }
            
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            
        } catch (Exception e) {
            System.out.println("Error in getOptionList: " + e.getMessage());
            e.printStackTrace();
        }
        
        return result.toString();
    }
    
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("✓ Database connection closed!");
            }
        } catch (Exception e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
}