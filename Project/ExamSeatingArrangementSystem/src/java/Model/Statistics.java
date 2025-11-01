package Model;

import java.util.*;
import java.sql.*;
import com.*;
import java.io.*;

public class Statistics extends Connect {

    public Statistics() {
        Connect.connect_mysql();
    }

    // Get Dashboard Statistics
    public HashMap getDashboardStats() {
        HashMap stats = new HashMap();
        try {
            statement = connection.createStatement();
            
            // Total Students
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `student`");
            if (rs.next()) {
                stats.put("total_students", rs.getInt("count"));
            }
            
            // Total Seats
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `seat`");
            if (rs.next()) {
                stats.put("total_seats", rs.getInt("count"));
            }
            
            // Assigned Seats
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `student_seat`");
            if (rs.next()) {
                stats.put("assigned_seats", rs.getInt("count"));
            }
            
            // Available Seats
            int totalSeats = (Integer) stats.get("total_seats");
            int assignedSeats = (Integer) stats.get("assigned_seats");
            stats.put("available_seats", totalSeats - assignedSeats);
            
            // Total Exams
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `exam`");
            if (rs.next()) {
                stats.put("total_exams", rs.getInt("count"));
            }
            
            // Upcoming Exams
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `exam` WHERE exam_date >= CURDATE() AND exam_status = 'Scheduled'");
            if (rs.next()) {
                stats.put("upcoming_exams", rs.getInt("count"));
            }
            
            // Total Rooms
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `room`");
            if (rs.next()) {
                stats.put("total_rooms", rs.getInt("count"));
            }
            
            // Total Blocks
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `block`");
            if (rs.next()) {
                stats.put("total_blocks", rs.getInt("count"));
            }
            
            // Total Floors
            rs = statement.executeQuery("SELECT COUNT(*) as count FROM `floor`");
            if (rs.next()) {
                stats.put("total_floors", rs.getInt("count"));
            }
            
            // Seat Utilization Percentage
            if (totalSeats > 0) {
                double utilization = (assignedSeats * 100.0) / totalSeats;
                stats.put("seat_utilization", Math.round(utilization * 100.0) / 100.0);
            } else {
                stats.put("seat_utilization", 0.0);
            }
            
        } catch (Exception e) {
            System.out.println("Error in getDashboardStats: " + e);
            e.printStackTrace();
        }
        return stats;
    }

    // Get Course-wise Statistics
    public ArrayList getCourseWiseStats() {
        ArrayList resultArray = new ArrayList();
        try {
            String SQL = "SELECT c.course_name, COUNT(DISTINCT s.student_id) as student_count, COUNT(DISTINCT ss.ss_id) as assigned_count " +
                        "FROM `course` c " +
                        "LEFT JOIN `student` s ON s.student_course_id = c.course_id " +
                        "LEFT JOIN `student_seat` ss ON ss.ss_student_id = s.student_id " +
                        "GROUP BY c.course_id, c.course_name";
            
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            
            while (rs.next()) {
                HashMap results = new HashMap();
                results.put("course_name", rs.getString("course_name"));
                results.put("student_count", rs.getInt("student_count"));
                results.put("assigned_count", rs.getInt("assigned_count"));
                resultArray.add(results);
            }
        } catch (Exception e) {
            System.out.println("Error in getCourseWiseStats: " + e);
        }
        return resultArray;
    }

    // Get Recent Activity
    public ArrayList getRecentActivity() {
        ArrayList resultArray = new ArrayList();
        try {
            // Get recent seat assignments
            String SQL = "SELECT ss.ss_id, s.student_name, s.student_rollno, st.seat_number, " +
                        "b.block_name, r.room_name, f.floor_name, ss.ss_description " +
                        "FROM `student_seat` ss " +
                        "INNER JOIN `student` s ON s.student_id = ss.ss_student_id " +
                        "INNER JOIN `seat` st ON st.seat_id = ss.ss_seat_id " +
                        "INNER JOIN `block` b ON b.block_id = st.seat_block_id " +
                        "INNER JOIN `room` r ON r.room_id = b.block_room_id " +
                        "INNER JOIN `floor` f ON f.floor_id = r.room_floor_id " +
                        "ORDER BY ss.ss_id DESC LIMIT 10";
            
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            
            while (rs.next()) {
                HashMap results = new HashMap();
                results.put("student_name", rs.getString("student_name"));
                results.put("student_rollno", rs.getString("student_rollno"));
                results.put("seat_number", rs.getString("seat_number"));
                results.put("block_name", rs.getString("block_name"));
                results.put("room_name", rs.getString("room_name"));
                results.put("floor_name", rs.getString("floor_name"));
                results.put("description", rs.getString("ss_description"));
                resultArray.add(results);
            }
        } catch (Exception e) {
            System.out.println("Error in getRecentActivity: " + e);
        }
        return resultArray;
    }
}

