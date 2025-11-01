package Model;

import java.util.*;
import java.sql.*;
import com.*;
import java.io.*;

public class Exam extends Connect {

    public Exam() {
        Connect.connect_mysql();
    }

    // Save Exam Details
    public String saveExam(HashMap examData) {
        String SQL = "INSERT INTO `exam` (`exam_name`, `exam_subject`, `exam_date`, `exam_start_time`, `exam_end_time`, `exam_duration`, `exam_status`, `exam_description`) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
        int record = 0;
        String error = "";

        try {
            pstmt = connection.prepareStatement(SQL);
            pstmt.setString(1, (String) examData.get("exam_name"));
            pstmt.setString(2, (String) examData.get("exam_subject"));
            pstmt.setString(3, (String) examData.get("exam_date"));
            pstmt.setString(4, (String) examData.get("exam_start_time"));
            pstmt.setString(5, (String) examData.get("exam_end_time"));
            pstmt.setString(6, (String) examData.get("exam_duration"));
            pstmt.setString(7, (String) examData.get("exam_status"));
            pstmt.setString(8, (String) examData.get("exam_description"));

            record = pstmt.executeUpdate();
            pstmt.close();
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

    // Get Exam Details
    public HashMap getExamDetails(int exam_id) {
        HashMap results = new HashMap();
        int count = 0;
        try {
            String SQL = "SELECT * FROM `exam` WHERE exam_id = " + exam_id;
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            while (rs.next()) {
                results.put("exam_id", rs.getString("exam_id"));
                results.put("exam_name", rs.getString("exam_name"));
                results.put("exam_subject", rs.getString("exam_subject"));
                results.put("exam_date", rs.getString("exam_date"));
                results.put("exam_start_time", rs.getString("exam_start_time"));
                results.put("exam_end_time", rs.getString("exam_end_time"));
                results.put("exam_duration", rs.getString("exam_duration"));
                results.put("exam_status", rs.getString("exam_status"));
                results.put("exam_description", rs.getString("exam_description"));
                count++;
            }
            if (count == 0) {
                results.put("exam_id", "");
                results.put("exam_name", "");
                results.put("exam_subject", "");
                results.put("exam_date", "");
                results.put("exam_start_time", "");
                results.put("exam_end_time", "");
                results.put("exam_duration", "");
                results.put("exam_status", "");
                results.put("exam_description", "");
            }
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return results;
    }

    // Update Exam
    public String updateExam(HashMap examData) {
        String SQL = "UPDATE `exam` SET `exam_name` = ?, `exam_subject` = ?, `exam_date` = ?, `exam_start_time` = ?, `exam_end_time` = ?, `exam_duration` = ?, `exam_status` = ?, `exam_description` = ? WHERE `exam_id` = ?;";
        String error = "";
        int record = 0;

        try {
            pstmt = connection.prepareStatement(SQL);
            pstmt.setString(1, (String) examData.get("exam_name"));
            pstmt.setString(2, (String) examData.get("exam_subject"));
            pstmt.setString(3, (String) examData.get("exam_date"));
            pstmt.setString(4, (String) examData.get("exam_start_time"));
            pstmt.setString(5, (String) examData.get("exam_end_time"));
            pstmt.setString(6, (String) examData.get("exam_duration"));
            pstmt.setString(7, (String) examData.get("exam_status"));
            pstmt.setString(8, (String) examData.get("exam_description"));
            pstmt.setString(9, (String) examData.get("exam_id"));

            record = pstmt.executeUpdate();
            pstmt.close();
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

    // Get All Exams
    public ArrayList getAllExam() {
        String SQL = "SELECT * FROM `exam` ORDER BY exam_date DESC, exam_start_time DESC";
        int count = 0;
        ArrayList resultArray = new ArrayList();
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            while (rs.next()) {
                HashMap results = new HashMap();
                results.put("exam_id", rs.getString("exam_id"));
                results.put("exam_name", rs.getString("exam_name"));
                results.put("exam_subject", rs.getString("exam_subject"));
                results.put("exam_date", rs.getString("exam_date"));
                results.put("exam_start_time", rs.getString("exam_start_time"));
                results.put("exam_end_time", rs.getString("exam_end_time"));
                results.put("exam_duration", rs.getString("exam_duration"));
                results.put("exam_status", rs.getString("exam_status"));
                results.put("exam_description", rs.getString("exam_description"));
                count++;
                resultArray.add(results);
            }
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return resultArray;
    }

    // Auto Assign Seats for Exam
    public String autoAssignSeatsForExam(int exam_id, String course_id) {
        String error = "";
        try {
            // Get all available seats
            String seatSQL = "SELECT seat_id FROM `seat` WHERE seat_id NOT IN (SELECT ss_seat_id FROM `student_seat` WHERE ss_seat_id IS NOT NULL) ORDER BY seat_id";
            statement = connection.createStatement();
            rs = statement.executeQuery(seatSQL);
            
            ArrayList availableSeats = new ArrayList();
            while (rs.next()) {
                availableSeats.add(rs.getInt("seat_id"));
            }
            
            // Get students by course
            String studentSQL = "SELECT student_id FROM `student` WHERE student_course_id = " + course_id;
            rs = statement.executeQuery(studentSQL);
            
            ArrayList students = new ArrayList();
            while (rs.next()) {
                students.add(rs.getInt("student_id"));
            }
            
            // Assign seats to students
            if (availableSeats.size() >= students.size()) {
                for (int i = 0; i < students.size(); i++) {
                    int studentId = (Integer) students.get(i);
                    int seatId = (Integer) availableSeats.get(i);
                    
                    // Check if assignment already exists
                    String checkSQL = "SELECT ss_id FROM `student_seat` WHERE ss_student_id = " + studentId + " AND ss_seat_id = " + seatId;
                    ResultSet checkRs = statement.executeQuery(checkSQL);
                    
                    if (!checkRs.next()) {
                        // Create new assignment
                        String insertSQL = "INSERT INTO `student_seat` (`ss_student_id`, `ss_seat_id`, `ss_description`, `ss_exam_id`) VALUES (?, ?, ?, ?)";
                        pstmt = connection.prepareStatement(insertSQL);
                        pstmt.setInt(1, studentId);
                        pstmt.setInt(2, seatId);
                        pstmt.setString(3, "Auto-assigned for exam");
                        pstmt.setInt(4, exam_id);
                        pstmt.executeUpdate();
                        pstmt.close();
                        
                        // Link to exam_seat_assignment
                        String examSeatSQL = "INSERT INTO `exam_seat_assignment` (`esa_exam_id`, `esa_student_seat_id`, `esa_status`) VALUES (?, (SELECT ss_id FROM `student_seat` WHERE ss_student_id = ? AND ss_seat_id = ? ORDER BY ss_id DESC LIMIT 1), 'Assigned')";
                        pstmt = connection.prepareStatement(examSeatSQL);
                        pstmt.setInt(1, exam_id);
                        pstmt.setInt(2, studentId);
                        pstmt.setInt(3, seatId);
                        pstmt.executeUpdate();
                        pstmt.close();
                    }
                }
            } else {
                error = "Not enough available seats. Required: " + students.size() + ", Available: " + availableSeats.size();
            }
            
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

    // Get Seat Availability for Exam
    public HashMap getSeatAvailability(int exam_id) {
        HashMap results = new HashMap();
        try {
            // Total seats
            String totalSQL = "SELECT COUNT(*) as total FROM `seat`";
            statement = connection.createStatement();
            rs = statement.executeQuery(totalSQL);
            int totalSeats = 0;
            if (rs.next()) {
                totalSeats = rs.getInt("total");
            }
            
            // Assigned seats for this exam
            String assignedSQL = "SELECT COUNT(*) as assigned FROM `exam_seat_assignment` WHERE esa_exam_id = " + exam_id;
            rs = statement.executeQuery(assignedSQL);
            int assignedSeats = 0;
            if (rs.next()) {
                assignedSeats = rs.getInt("assigned");
            }
            
            results.put("total_seats", totalSeats);
            results.put("assigned_seats", assignedSeats);
            results.put("available_seats", totalSeats - assignedSeats);
            
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return results;
    }
}

