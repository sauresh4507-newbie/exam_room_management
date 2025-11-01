package Model;

import java.util.*;
import java.sql.*;
import com.*;
import java.io.*;

public class StudentSeat extends Connect {

    /////Function for connect to the MySQL Server Database////////////

    public StudentSeat() {
        Connect.connect_mysql();
    }

    //////////Save User Details /////

    public String saveStudentSeat(HashMap studentSeatData) {
        String SQL = "INSERT INTO student_seat (`ss_student_id`, `ss_seat_id`, `ss_exam_id`, `ss_description`) VALUES (?, ?, ?, ?);";
        int record = 0;
        String error = "";

        try {
            pstmt = connection.prepareStatement(SQL);
            pstmt.setString(1, (String) studentSeatData.get("ss_student_id"));
            pstmt.setString(2, (String) studentSeatData.get("ss_seat_id"));
            pstmt.setString(3, (String) studentSeatData.get("ss_exam_id"));
            pstmt.setString(4, (String) studentSeatData.get("ss_description"));

            record = pstmt.executeUpdate();
            pstmt.close();
            connection.close();
        } catch (Exception e) {
            StringWriter writer = new StringWriter();
            PrintWriter printWriter = new PrintWriter(writer);
            e.printStackTrace(printWriter);
            printWriter.flush();
            String stackTrace = writer.toString();
            error += "Error : " + stackTrace;
            System.out.println(" Error : " + e.toString());
        }
        return error;
    }
	//////////////////Function for getting Users Details//////////	

    public HashMap getStudentSeatDetails(int ss_id) {
        HashMap results = new HashMap();
        int count = 0;
        try {
            String SQL = "SELECT * FROM student_seat WHERE ss_id = " + ss_id;
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            while (rs.next()) {
                results.put("ss_id", rs.getString("ss_id"));
                results.put("ss_seat_id", Integer.parseInt(rs.getString("ss_seat_id")));
                results.put("ss_student_id", Integer.parseInt(rs.getString("ss_student_id")));
                results.put("ss_exam_id", rs.getString("ss_exam_id") != null ? Integer.parseInt(rs.getString("ss_exam_id")) : 0);
                results.put("ss_description", rs.getString("ss_description"));
                count++;
            }
            if (count == 0) {
                results.put("ss_id", "");
                results.put("ss_seat_id", 0);
                results.put("ss_student_id", 0);
                results.put("ss_exam_id", 0);
                results.put("ss_description", "");
            }
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return results;
    }

    /// Update the StudentSeat ////

    public String updateStudentSeat(HashMap studentSeatData) {
        String SQL = "UPDATE student_seat SET `ss_student_id` = ?, `ss_seat_id` = ?, `ss_exam_id` = ?, `ss_description` = ? WHERE `ss_id` = ?;";
        String error = "";

        int record = 0;

        try {
            pstmt = connection.prepareStatement(SQL);

            pstmt.setString(1, (String) studentSeatData.get("ss_student_id"));
            pstmt.setString(2, (String) studentSeatData.get("ss_seat_id"));
            pstmt.setString(3, (String) studentSeatData.get("ss_exam_id"));
            pstmt.setString(4, (String) studentSeatData.get("ss_description"));
            pstmt.setString(5, (String) studentSeatData.get("ss_id"));

            record = pstmt.executeUpdate();
            pstmt.close();
            connection.close();
        } catch (Exception e) {
            StringWriter writer = new StringWriter();
            PrintWriter printWriter = new PrintWriter(writer);
            e.printStackTrace(printWriter);
            printWriter.flush();
            String stackTrace = writer.toString();
            error += "Error : " + stackTrace;
            System.out.println(" Error : " + e.toString());
        }
        return error;
    }

	////////////////Function for getting all the Airport Details////////////////////  
    public ArrayList getAllStudentSeat() {
        String SQL = "SELECT * FROM `seat`,`block`,`room`,`floor`,`student_seat`,`student` WHERE student_id = ss_student_id AND ss_seat_id = seat_id AND block_room_id = room_id AND block_id = seat_block_id AND room_floor_id = floor_id";
        int count = 0;
        ArrayList resultArray = new ArrayList();
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            while (rs.next()) {
                HashMap results = new HashMap();
                results.put("ss_id", rs.getString("ss_id"));
                results.put("floor_name", rs.getString("floor_name"));
                results.put("room_name", rs.getString("room_name"));
                results.put("block_name", rs.getString("block_name"));
                results.put("seat_number", rs.getString("seat_number"));
                results.put("student_rollno", rs.getString("student_rollno"));
                results.put("student_name", rs.getString("student_name"));
                results.put("ss_description", rs.getString("ss_description"));

                count++;
                resultArray.add(results);
            }
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return resultArray;
    }

    public HashMap getStudentSeats(String student_id) {
        HashMap results = new HashMap();
        int count = 0;
        try {
            String SQL = "SELECT * FROM `seat`,`block`,`room`,`floor`,`student_seat`,`student` WHERE student_id = ss_student_id AND ss_seat_id = seat_id AND block_room_id = room_id AND block_id = seat_block_id AND room_floor_id = floor_id AND student_rollno = " + student_id;
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            while (rs.next()) {
                results.put("ss_id", rs.getString("ss_id"));
                results.put("floor_name", rs.getString("floor_name"));
                results.put("room_name", rs.getString("room_name"));
                results.put("block_name", rs.getString("block_name"));
                results.put("seat_number", rs.getString("seat_number"));
                results.put("student_rollno", rs.getString("student_rollno"));
                results.put("student_name", rs.getString("student_name"));
                results.put("student_father_name", rs.getString("student_father_name"));
                results.put("ss_description", rs.getString("ss_description"));
                count++;
            }
            if (count == 0) {
                results.put("ss_id", "");
                results.put("ss_seat_id", 0);
                results.put("ss_student_id", 0);
                results.put("ss_description", "");
            }
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return results;
    }

    /////Function for Getting the List////////////

    public String getSeatOption(Integer SelID) {
        int selectedID = SelID.intValue();
        return Connect.getOptionList("seat", "seat_id", "seat_number", "seat_id,seat_number", selectedID, "1");
    }

    /////Function for Getting the List////////////

    public String getStudentOption(Integer SelID) {
        int selectedID = SelID.intValue();
        return Connect.getOptionList("student", "student_id", "student_rollno", "student_id,student_rollno", selectedID, "1");
    }

    /////Function for Getting the Exam List////////////

    public String getExamOption(Integer SelID) {
        int selectedID = SelID.intValue();
        return Connect.getOptionList("exam", "exam_id", "exam_name", "exam_id,exam_name", selectedID, "1");
    }

    /////Function to get available seats for an exam////////////
    public ArrayList getAvailableSeatsForExam(int exam_id, int room_id) {
        ArrayList resultArray = new ArrayList();
        try {
            String SQL = "SELECT s.*, b.block_name, r.room_name " +
                        "FROM seat s " +
                        "JOIN block b ON s.seat_block_id = b.block_id " +
                        "JOIN room r ON b.block_room_id = r.room_id " +
                        "LEFT JOIN student_seat ss ON s.seat_id = ss.ss_seat_id AND ss.ss_exam_id = ? " +
                        "WHERE r.room_id = ? AND ss.ss_id IS NULL " +
                        "ORDER BY s.seat_id";
            pstmt = connection.prepareStatement(SQL);
            pstmt.setInt(1, exam_id);
            pstmt.setInt(2, room_id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                HashMap results = new HashMap();
                results.put("seat_id", rs.getString("seat_id"));
                results.put("seat_number", rs.getString("seat_number"));
                results.put("block_name", rs.getString("block_name"));
                results.put("room_name", rs.getString("room_name"));
                resultArray.add(results);
            }
        } catch (Exception e) {
            System.out.println("Error getting available seats: " + e);
        }
        return resultArray;
    }

    /////Function to get statistics////////////
    public HashMap getSeatingStatistics() {
        HashMap stats = new HashMap();
        try {
            // Total seat assignments
            String SQL = "SELECT COUNT(*) as total FROM student_seat";
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            if (rs.next()) {
                stats.put("total_assignments", rs.getInt("total"));
            }

            // Total available seats
            SQL = "SELECT COUNT(*) as total FROM seat WHERE seat_id NOT IN (SELECT DISTINCT ss_seat_id FROM student_seat WHERE ss_seat_id IS NOT NULL)";
            rs = statement.executeQuery(SQL);
            if (rs.next()) {
                stats.put("available_seats", rs.getInt("total"));
            }

            // Total seats
            SQL = "SELECT COUNT(*) as total FROM seat";
            rs = statement.executeQuery(SQL);
            if (rs.next()) {
                stats.put("total_seats", rs.getInt("total"));
            }
        } catch (Exception e) {
            System.out.println("Error getting seating statistics: " + e);
        }
        return stats;
    }
}
