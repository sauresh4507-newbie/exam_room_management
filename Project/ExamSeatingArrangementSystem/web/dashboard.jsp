<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>
<%@ include file="includes/check_login.jsp" %>

<%
	Statistics statsObj = new Statistics();
	HashMap dashboardStats = statsObj.getDashboardStats();
	ArrayList courseStats = statsObj.getCourseWiseStats();
	ArrayList recentActivity = statsObj.getRecentActivity();
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <h2>Dashboard - System Overview</h2>
      
      <!-- Statistics Cards -->
      <div style="display: flex; flex-wrap: wrap; gap: 20px; margin: 20px 0;">
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #4CAF50; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(dashboardStats.get("total_students")); %></h3>
          <p style="margin: 5px 0 0 0;">Total Students</p>
        </div>
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #2196F3; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(dashboardStats.get("total_seats")); %></h3>
          <p style="margin: 5px 0 0 0;">Total Seats</p>
        </div>
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #FF9800; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(dashboardStats.get("assigned_seats")); %></h3>
          <p style="margin: 5px 0 0 0;">Assigned Seats</p>
        </div>
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #9C27B0; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(dashboardStats.get("available_seats")); %></h3>
          <p style="margin: 5px 0 0 0;">Available Seats</p>
        </div>
      </div>
      
      <div style="display: flex; flex-wrap: wrap; gap: 20px; margin: 20px 0;">
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #F44336; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(dashboardStats.get("total_exams")); %></h3>
          <p style="margin: 5px 0 0 0;">Total Exams</p>
        </div>
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #00BCD4; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(dashboardStats.get("upcoming_exams")); %></h3>
          <p style="margin: 5px 0 0 0;">Upcoming Exams</p>
        </div>
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #795548; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(dashboardStats.get("total_rooms")); %></h3>
          <p style="margin: 5px 0 0 0;">Total Rooms</p>
        </div>
        <div style="flex: 1; min-width: 200px; padding: 20px; background-color: #607D8B; color: white; border-radius: 5px;">
          <h3 style="margin: 0; font-size: 36px;"><% out.print(String.format("%.1f", dashboardStats.get("seat_utilization"))); %>%</h3>
          <p style="margin: 5px 0 0 0;">Seat Utilization</p>
        </div>
      </div>
      
      <!-- Course-wise Statistics -->
      <div style="margin: 30px 0;">
        <h3>Course-wise Statistics</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <thead>
            <tr style="background-color: #f5f5f5;">
              <th style="padding: 10px; border: 1px solid #ddd;">Course Name</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Total Students</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Assigned Seats</th>
            </tr>
          </thead>
          <tbody>
            <% for(int i=0; i<courseStats.size(); i++) {
                HashMap course = (HashMap)courseStats.get(i);
            %>
            <tr>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(course.get("course_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd; text-align: center;"><% out.print(course.get("student_count")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd; text-align: center;"><% out.print(course.get("assigned_count")); %></td>
            </tr>
            <% } %>
            <% if(courseStats.size() == 0) { %>
            <tr>
              <td colspan="3" style="padding: 10px; text-align: center;">No course data available</td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
      
      <!-- Recent Activity -->
      <div style="margin: 30px 0;">
        <h3>Recent Seat Assignments</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <thead>
            <tr style="background-color: #f5f5f5;">
              <th style="padding: 10px; border: 1px solid #ddd;">Student Name</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Roll No</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Seat</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Block</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Room</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Floor</th>
            </tr>
          </thead>
          <tbody>
            <% for(int i=0; i<recentActivity.size(); i++) {
                HashMap activity = (HashMap)recentActivity.get(i);
            %>
            <tr>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(activity.get("student_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(activity.get("student_rollno")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(activity.get("seat_number")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(activity.get("block_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(activity.get("room_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(activity.get("floor_name")); %></td>
            </tr>
            <% } %>
            <% if(recentActivity.size() == 0) { %>
            <tr>
              <td colspan="6" style="padding: 10px; text-align: center;">No recent activity</td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
      
      <div class="clear"></div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>

