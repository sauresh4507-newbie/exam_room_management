package Model;

import java.util.*;
import java.sql.*;
import com.*;
import java.io.*;

public class Exam extends Connect {

    /////Function for connect to the MySQL Server Database////////////

    public Exam() {
        Connect.connect_mysql();
    }

    //////////Save Exam Details /////

    public String saveExam(HashMap examData) {
        String SQL = "INSERT INTO `exam` (`exam_name`, `exam_subject`, `exam_date`, `exam_start_time`, `exam_end_time`, `exam_room_id`, `exam_course_id`, `exam_description`, `exam_status`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        int record = 0;
        String error = "";

        try {
            pstmt = connection.prepareStatement(SQL);
            pstmt.setString(1, (String) examData.get("exam_name"));
            pstmt.setString(2, (String) examData.get("exam_subject"));
            pstmt.setString(3, (String) examData.get("exam_date"));
            pstmt.setString(4, (String) examData.get("exam_start_time"));
            pstmt.setString(5, (String) examData.get("exam_end_time"));
            pstmt.setString(6, (String) examData.get("exam_room_id"));
            pstmt.setString(7, (String) examData.get("exam_course_id"));
            pstmt.setString(8, (String) examData.get("exam_description"));
            pstmt.setString(9, (String) examData.get("exam_status"));

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

    //////////////////Function for getting Exam Details//////////	

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
                results.put("exam_room_id", rs.getString("exam_room_id"));
                results.put("exam_course_id", rs.getString("exam_course_id"));
                results.put("exam_description", rs.getString("exam_description"));
                results.put("exam_status", rs.getString("exam_status"));
                count++;
            }
            if (count == 0) {
                results.put("exam_id", "");
                results.put("exam_name", "");
                results.put("exam_subject", "");
                results.put("exam_date", "");
                results.put("exam_start_time", "");
                results.put("exam_end_time", "");
                results.put("exam_room_id", "");
                results.put("exam_course_id", "");
                results.put("exam_description", "");
                results.put("exam_status", "Scheduled");
            }
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return results;
    }

    /// Update the Exam ////

    public String updateExam(HashMap examData) {
        String SQL = "UPDATE `exam` SET `exam_name` = ?, `exam_subject` = ?, `exam_date` = ?, `exam_start_time` = ?, `exam_end_time` = ?, `exam_room_id` = ?, `exam_course_id` = ?, `exam_description` = ?, `exam_status` = ? WHERE `exam_id` = ?;";
        String error = "";

        int record = 0;

        try {
            pstmt = connection.prepareStatement(SQL);

            pstmt.setString(1, (String) examData.get("exam_name"));
            pstmt.setString(2, (String) examData.get("exam_subject"));
            pstmt.setString(3, (String) examData.get("exam_date"));
            pstmt.setString(4, (String) examData.get("exam_start_time"));
            pstmt.setString(5, (String) examData.get("exam_end_time"));
            pstmt.setString(6, (String) examData.get("exam_room_id"));
            pstmt.setString(7, (String) examData.get("exam_course_id"));
            pstmt.setString(8, (String) examData.get("exam_description"));
            pstmt.setString(9, (String) examData.get("exam_status"));
            pstmt.setString(10, (String) examData.get("exam_id"));

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

    ////////////////Function for getting all the Exam Details////////////////////  
    public ArrayList getAllExam() {
        String SQL = "SELECT e.*, r.room_name, c.course_name FROM `exam` e LEFT JOIN `room` r ON e.exam_room_id = r.room_id LEFT JOIN `course` c ON e.exam_course_id = c.course_id ORDER BY e.exam_date, e.exam_start_time";
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
                results.put("exam_room_id", rs.getString("exam_room_id"));
                results.put("room_name", rs.getString("room_name") != null ? rs.getString("room_name") : "Not Assigned");
                results.put("exam_course_id", rs.getString("exam_course_id"));
                results.put("course_name", rs.getString("course_name") != null ? rs.getString("course_name") : "Not Assigned");
                results.put("exam_description", rs.getString("exam_description"));
                results.put("exam_status", rs.getString("exam_status"));

                count++;
                resultArray.add(results);
            }
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
        return resultArray;
    }

    /////Function for Getting the List////////////

    public String getRoomOption(Integer SelID) {
        int selectedID = SelID.intValue();
        return Connect.getOptionList("room", "room_id", "room_name", "room_id,room_name", selectedID, "1");
    }

    /////Function for Getting the Course List////////////

    public String getCourseOption(Integer SelID) {
        int selectedID = SelID.intValue();
        return Connect.getOptionList("course", "course_id", "course_name", "course_id,course_name", selectedID, "1");
    }

    /////Function for getting exam statistics////////////
    public HashMap getExamStatistics() {
        HashMap stats = new HashMap();
        try {
            // Total exams
            String SQL = "SELECT COUNT(*) as total FROM exam";
            statement = connection.createStatement();
            rs = statement.executeQuery(SQL);
            if (rs.next()) {
                stats.put("total_exams", rs.getInt("total"));
            }

            // Scheduled exams
            SQL = "SELECT COUNT(*) as total FROM exam WHERE exam_status = 'Scheduled'";
            rs = statement.executeQuery(SQL);
            if (rs.next()) {
                stats.put("scheduled_exams", rs.getInt("total"));
            }

            // Completed exams
            SQL = "SELECT COUNT(*) as total FROM exam WHERE exam_status = 'Completed'";
            rs = statement.executeQuery(SQL);
            if (rs.next()) {
                stats.put("completed_exams", rs.getInt("total"));
            }

            // Upcoming exams (today or future)
            SQL = "SELECT COUNT(*) as total FROM exam WHERE exam_date >= CURDATE() AND exam_status = 'Scheduled'";
            rs = statement.executeQuery(SQL);
            if (rs.next()) {
                stats.put("upcoming_exams", rs.getInt("total"));
            }
        } catch (Exception e) {
            System.out.println("Error getting exam statistics: " + e);
        }
        return stats;
    }
}

