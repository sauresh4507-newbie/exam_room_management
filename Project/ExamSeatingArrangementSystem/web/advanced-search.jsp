<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>
<%@ include file="includes/check_login.jsp" %>

<%
	StudentSeat studentSeatObj = new StudentSeat();
	ArrayList allStudentSeat = new ArrayList();
	
	// Get search parameters
	String searchRollNo = request.getParameter("search_rollno");
	String searchName = request.getParameter("search_name");
	String searchCourse = request.getParameter("search_course");
	String searchFloor = request.getParameter("search_floor");
	String searchRoom = request.getParameter("search_room");
	
	String whereClause = " WHERE 1=1 ";
	
	if(searchRollNo != null && !searchRollNo.equals("")) {
		whereClause += " AND student_rollno LIKE '%" + searchRollNo + "%'";
	}
	if(searchName != null && !searchName.equals("")) {
		whereClause += " AND student_name LIKE '%" + searchName + "%'";
	}
	if(searchCourse != null && !searchCourse.equals("")) {
		whereClause += " AND student_course_id = " + searchCourse;
	}
	if(searchFloor != null && !searchFloor.equals("")) {
		whereClause += " AND floor_id = " + searchFloor;
	}
	if(searchRoom != null && !searchRoom.equals("")) {
		whereClause += " AND room_id = " + searchRoom;
	}
	
	// Build custom query
	String SQL = "SELECT * FROM `seat`,`block`,`room`,`floor`,`student_seat`,`student` WHERE student_id = ss_student_id AND ss_seat_id = seat_id AND block_room_id = room_id AND block_id = seat_block_id AND room_floor_id = floor_id" + whereClause.replace("WHERE 1=1", "");
	
	Floor floorObj = new Floor();
	Room roomObj = new Room();
	Student studentObj = new Student();
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div id="comments" style="width: 100%;">
      <h2>Advanced Search</h2>
        <form action="advanced-search.jsp" method="get">
          <div style="display: flex; flex-wrap: wrap; gap: 15px; margin: 20px 0;">
            <div style="flex: 1; min-width: 200px;">
              <label for="search_rollno">Roll Number:</label>
              <input type="text" name="search_rollno" id="search_rollno" value="<%= searchRollNo != null ? searchRollNo : "" %>" style="width: 100%;">
            </div>
            <div style="flex: 1; min-width: 200px;">
              <label for="search_name">Student Name:</label>
              <input type="text" name="search_name" id="search_name" value="<%= searchName != null ? searchName : "" %>" style="width: 100%;">
            </div>
            <div style="flex: 1; min-width: 200px;">
              <label for="search_course">Course:</label>
              <select name="search_course" id="search_course" style="width: 100%;">
                <option value="">-- All Courses --</option>
                <% 
                  if(studentObj != null) {
                    out.print(studentObj.getCourseOption(0)); 
                  }
                %>
              </select>
            </div>
            <div style="flex: 1; min-width: 200px;">
              <label for="search_floor">Floor:</label>
              <select name="search_floor" id="search_floor" style="width: 100%;">
                <option value="">-- All Floors --</option>
                <% 
                  if(floorObj != null) {
                    out.print(floorObj.getFloorOption(0)); 
                  }
                %>
              </select>
            </div>
            <div style="flex: 1; min-width: 200px;">
              <label for="search_room">Room:</label>
              <select name="search_room" id="search_room" style="width: 100%;">
                <option value="">-- All Rooms --</option>
                <% 
                  if(roomObj != null) {
                    out.print(roomObj.getRoomOption(0)); 
                  }
                %>
              </select>
            </div>
          </div>
          <div style="margin: 20px 0;">
            <input name="submit" type="submit" value="Search">
            &nbsp;
            <input name="reset" type="reset" value="Reset">
            &nbsp;
            <a href="report-student-seat.jsp">View All</a>
          </div>
        </form>
        
        <!-- Search Results -->
        <% 
          if(searchRollNo != null || searchName != null || searchCourse != null || searchFloor != null || searchRoom != null) {
            try {
              Connect.connect_mysql();
              Statement stmt = Connect.connection.createStatement();
              ResultSet rs = stmt.executeQuery(SQL);
              
              ArrayList results = new ArrayList();
              while(rs.next()) {
                HashMap result = new HashMap();
                result.put("ss_id", rs.getString("ss_id"));
                result.put("floor_name", rs.getString("floor_name"));
                result.put("room_name", rs.getString("room_name"));
                result.put("block_name", rs.getString("block_name"));
                result.put("seat_number", rs.getString("seat_number"));
                result.put("student_rollno", rs.getString("student_rollno"));
                result.put("student_name", rs.getString("student_name"));
                result.put("ss_description", rs.getString("ss_description"));
                results.add(result);
              }
        %>
        <h3>Search Results (<%= results.size() %> found)</h3>
        <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
          <thead>
            <tr style="background-color: #f5f5f5;">
              <th style="padding: 10px; border: 1px solid #ddd;">Roll No</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Student Name</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Floor</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Room</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Block</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Seat</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Action</th>
            </tr>
          </thead>
          <tbody>
            <% for(int i=0; i<results.size(); i++) {
                HashMap result = (HashMap)results.get(i);
            %>
            <tr>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(result.get("student_rollno")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(result.get("student_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(result.get("floor_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(result.get("room_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(result.get("block_name")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(result.get("seat_number")); %></td>
              <td style="padding: 10px; border: 1px solid #ddd;">
                <a href="model/student-seat.jsp?ss_id=<% out.print(result.get("ss_id")); %>&act=Edit">Edit</a>
              </td>
            </tr>
            <% } %>
            <% if(results.size() == 0) { %>
            <tr>
              <td colspan="7" style="padding: 10px; text-align: center;">No results found</td>
            </tr>
            <% } %>
          </tbody>
        </table>
        <% 
            } catch(Exception e) {
              out.println("Error: " + e.getMessage());
            }
          }
        %>
        </div>
      <div class="clear"></div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>

