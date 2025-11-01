<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>

<%
	Exam examObj = new Exam();
	StudentSeat seatObj = new StudentSeat();
	Student studentObj = new Student();
	Room roomObj = new Room();
	
	HashMap examStats = examObj.getExamStatistics();
	HashMap seatStats = seatObj.getSeatingStatistics();
	
	// Get total students
	int totalStudents = 0;
	try {
		ArrayList allStudents = studentObj.getAllStudent();
		totalStudents = allStudents.size();
	} catch (Exception e) {
		System.out.println("Error: " + e);
	}
	
	// Get total rooms
	int totalRooms = 0;
	try {
		ArrayList allRooms = roomObj.getAllRoom();
		totalRooms = allRooms.size();
	} catch (Exception e) {
		System.out.println("Error: " + e);
	}
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <h2 style="text-align: center; margin-bottom: 30px;">System Dashboard</h2>
      
      <div style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 30px;">
        <!-- Total Students Card -->
        <div style="flex: 1; min-width: 200px; background-color: #3498db; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Total Students</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= totalStudents %></div>
        </div>
        
        <!-- Total Rooms Card -->
        <div style="flex: 1; min-width: 200px; background-color: #27ae60; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Total Rooms</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= totalRooms %></div>
        </div>
        
        <!-- Total Seats Card -->
        <div style="flex: 1; min-width: 200px; background-color: #e74c3c; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Total Seats</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= seatStats.get("total_seats") != null ? seatStats.get("total_seats") : 0 %></div>
        </div>
        
        <!-- Available Seats Card -->
        <div style="flex: 1; min-width: 200px; background-color: #f39c12; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Available Seats</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= seatStats.get("available_seats") != null ? seatStats.get("available_seats") : 0 %></div>
        </div>
      </div>
      
      <div style="display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 30px;">
        <!-- Total Exams Card -->
        <div style="flex: 1; min-width: 200px; background-color: #9b59b6; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Total Exams</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= examStats.get("total_exams") != null ? examStats.get("total_exams") : 0 %></div>
        </div>
        
        <!-- Scheduled Exams Card -->
        <div style="flex: 1; min-width: 200px; background-color: #16a085; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Scheduled Exams</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= examStats.get("scheduled_exams") != null ? examStats.get("scheduled_exams") : 0 %></div>
        </div>
        
        <!-- Upcoming Exams Card -->
        <div style="flex: 1; min-width: 200px; background-color: #2980b9; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Upcoming Exams</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= examStats.get("upcoming_exams") != null ? examStats.get("upcoming_exams") : 0 %></div>
        </div>
        
        <!-- Seat Assignments Card -->
        <div style="flex: 1; min-width: 200px; background-color: #c0392b; color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
          <h3 style="margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase;">Seat Assignments</h3>
          <div style="font-size: 48px; font-weight: bold;"><%= seatStats.get("total_assignments") != null ? seatStats.get("total_assignments") : 0 %></div>
        </div>
      </div>
      
      <!-- Quick Actions -->
      <div style="background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-top: 30px;">
        <h3 style="margin-top: 0;">Quick Actions</h3>
        <div style="display: flex; flex-wrap: wrap; gap: 10px;">
          <a href="exam.jsp?exam_id=0" style="background-color: #3498db; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Add New Exam</a>
          <a href="report-exam.jsp" style="background-color: #27ae60; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">View All Exams</a>
          <a href="student_seat.jsp?ss_id=0" style="background-color: #e74c3c; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Assign Seat</a>
          <a href="report-student-seat.jsp" style="background-color: #f39c12; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">View Assignments</a>
          <a href="student.jsp?student_id=0" style="background-color: #9b59b6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Add Student</a>
          <a href="room.jsp?room_id=0" style="background-color: #16a085; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Add Room</a>
        </div>
      </div>
      
      <div class="clear"></div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>

