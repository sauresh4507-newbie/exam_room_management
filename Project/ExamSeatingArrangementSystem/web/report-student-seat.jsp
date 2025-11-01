<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>

<%
	StudentSeat roomDetails = new StudentSeat();
	String employeeID = "0";
	ArrayList allStudentSeat = roomDetails.getAllStudentSeat();
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div class="scrollable">
        <h2>Student Seat Report</h2>
		<% if(request.getParameter("msg") != null) { %>
		<div class="msg" style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 20px; border-radius: 5px;"><%=request.getParameter("msg") %></div>
		<% } %>
		
		<!-- Search Form -->
		<form action="report-student-seat.jsp" method="get" style="background-color: #f8f9fa; padding: 15px; margin-bottom: 20px; border-radius: 5px;">
			<div style="display: flex; gap: 15px; flex-wrap: wrap; align-items: end;">
				<div>
					<label for="search_rollno">Search by Roll No:</label>
					<input type="text" name="search_rollno" id="search_rollno" value="<%= request.getParameter("search_rollno") != null ? request.getParameter("search_rollno") : "" %>" style="height: 35px; padding: 5px;">
				</div>
				<div>
					<label for="search_name">Search by Name:</label>
					<input type="text" name="search_name" id="search_name" value="<%= request.getParameter("search_name") != null ? request.getParameter("search_name") : "" %>" style="height: 35px; padding: 5px;">
				</div>
				<div>
					<label for="search_room">Search by Room:</label>
					<input type="text" name="search_room" id="search_room" value="<%= request.getParameter("search_room") != null ? request.getParameter("search_room") : "" %>" style="height: 35px; padding: 5px;">
				</div>
				<div>
					<input type="submit" value="Search" style="background-color: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
					<a href="report-student-seat.jsp" style="background-color: #95a5a6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Reset</a>
				</div>
			</div>
		</form>
		
		<%
			// Filter assignments based on search criteria
			String searchRollno = request.getParameter("search_rollno");
			String searchName = request.getParameter("search_name");
			String searchRoom = request.getParameter("search_room");
			
			if(searchRollno != null || searchName != null || searchRoom != null) {
				ArrayList filteredAssignments = new ArrayList();
				for(int i=0; i<allStudentSeat.size(); i++) {
					HashMap assignment = (HashMap)allStudentSeat.get(i);
					boolean match = true;
					
					if(searchRollno != null && !searchRollno.equals("")) {
						if(!assignment.get("student_rollno").toString().toLowerCase().contains(searchRollno.toLowerCase())) {
							match = false;
						}
					}
					
					if(match && searchName != null && !searchName.equals("")) {
						if(!assignment.get("student_name").toString().toLowerCase().contains(searchName.toLowerCase())) {
							match = false;
						}
					}
					
					if(match && searchRoom != null && !searchRoom.equals("")) {
						if(!assignment.get("room_name").toString().toLowerCase().contains(searchRoom.toLowerCase())) {
							match = false;
						}
					}
					
					if(match) {
						filteredAssignments.add(assignment);
					}
				}
				allStudentSeat = filteredAssignments;
			}
		%>
		
        <table>
          <thead>
            <tr>
              <th>Roll No</th>
			  <th>Student Name</th>
              <th>Floor</th>
			  <th>Room</th>
			  <th>Block</th>
			  <th>Seat</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
			<% for(int i=0;i<allStudentSeat.size();i++) 
			{ 
				HashMap StudentSeatDetails = new HashMap();
				StudentSeatDetails = (HashMap)allStudentSeat.get(i);
			%>
				<tr>
				  <td style="text-align:center;"><% out.print(StudentSeatDetails.get("student_rollno")); %></td>
				  <td><% out.print(StudentSeatDetails.get("student_name")); %></td>
				  <td><% out.print(StudentSeatDetails.get("floor_name")); %></td>
				  <td><% out.print(StudentSeatDetails.get("room_name")); %></td>
				  <td><% out.print(StudentSeatDetails.get("block_name")); %></td>
				  <td><% out.print(StudentSeatDetails.get("seat_number")); %></td>
				  <td> 
					<a href="student_seat.jsp?ss_id=<% out.print(StudentSeatDetails.get("ss_id")); %>">Edit</a>
				  </td>
				</tr>
			<%
			}
			if(allStudentSeat.size() == 0) 
			{
			%>
				<tr>
					<td colspan="7" style="text-align: center; padding: 20px;">No Records Found !!!</td>
				</tr>
			<%
			}
			%>
			</tbody>
        </table>
        <div style="margin-top: 15px; color: #666;">
          Total Records: <%= allStudentSeat.size() %>
        </div>
        </div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>
