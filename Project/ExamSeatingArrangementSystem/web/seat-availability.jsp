<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>

<%
	Exam examObj = new Exam();
	StudentSeat seatObj = new StudentSeat();
	Room roomObj = new Room();
	
	ArrayList allExams = examObj.getAllExam();
	ArrayList allRooms = roomObj.getAllRoom();
	
	String exam_id = request.getParameter("exam_id") != null ? request.getParameter("exam_id") : "";
	String room_id = request.getParameter("room_id") != null ? request.getParameter("room_id") : "";
	
	ArrayList availableSeats = new ArrayList();
	if (!exam_id.equals("") && !room_id.equals("") && !exam_id.equals("0") && !room_id.equals("0")) {
		availableSeats = seatObj.getAvailableSeatsForExam(Integer.parseInt(exam_id), Integer.parseInt(room_id));
	}
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div id="comments" style="width: 100%;">
      <h2>Seat Availability Checker</h2>
      <div align="center" style="color:#FF0000"><% if(request.getParameter("msg")!=null) out.print(request.getParameter("msg")); %></div><br />
      
        <form action="seat-availability.jsp" method="get" style="background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-bottom: 20px;">
          <div style="display: flex; gap: 20px; flex-wrap: wrap; align-items: end;">
            <div style="flex: 1; min-width: 250px;">
              <label for="exam_id">Select Exam<span>*</span></label>
              <select style="height: 40px; width:100%; padding: 5px;" name="exam_id" id="exam_id" required>
                <option value="">Select Exam</option>
                <% for(int i=0; i<allExams.size(); i++) {
                    HashMap exam = (HashMap)allExams.get(i);
                %>
                  <option value="<%= exam.get("exam_id") %>" <%= exam_id.equals(exam.get("exam_id").toString()) ? "selected" : "" %>>
                    <%= exam.get("exam_name") %> - <%= exam.get("exam_subject") %>
                  </option>
                <% } %>
              </select>
            </div>
            <div style="flex: 1; min-width: 250px;">
              <label for="room_id">Select Room<span>*</span></label>
              <select style="height: 40px; width:100%; padding: 5px;" name="room_id" id="room_id" required>
                <option value="">Select Room</option>
                <% for(int i=0; i<allRooms.size(); i++) {
                    HashMap room = (HashMap)allRooms.get(i);
                %>
                  <option value="<%= room.get("room_id") %>" <%= room_id.equals(room.get("room_id").toString()) ? "selected" : "" %>>
                    <%= room.get("room_name") %>
                  </option>
                <% } %>
              </select>
            </div>
            <div>
              <input type="submit" value="Check Availability" style="background-color: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
            </div>
          </div>
        </form>
        
        <% if (!availableSeats.isEmpty()) { %>
        <div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
          <strong>Found <%= availableSeats.size() %> available seat(s) for the selected exam and room.</strong>
        </div>
        
        <table style="width: 100%; border-collapse: collapse;">
          <thead>
            <tr style="background-color: #f2f2f2;">
              <th style="padding: 10px; border: 1px solid #ddd;">Seat Number</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Block</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Room</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Action</th>
            </tr>
          </thead>
          <tbody>
            <% for(int i=0; i<availableSeats.size(); i++) {
                HashMap seat = (HashMap)availableSeats.get(i);
            %>
              <tr>
                <td style="padding: 10px; border: 1px solid #ddd; text-align: center;"><%= seat.get("seat_number") %></td>
                <td style="padding: 10px; border: 1px solid #ddd;"><%= seat.get("block_name") %></td>
                <td style="padding: 10px; border: 1px solid #ddd;"><%= seat.get("room_name") %></td>
                <td style="padding: 10px; border: 1px solid #ddd;">
                  <a href="student_seat.jsp?ss_id=0&seat_id=<%= seat.get("seat_id") %>&exam_id=<%= exam_id %>" style="color: #0066cc;">Assign to Student</a>
                </td>
              </tr>
            <% } %>
          </tbody>
        </table>
        <% } else if (!exam_id.equals("") && !room_id.equals("") && !exam_id.equals("0") && !room_id.equals("0")) { %>
        <div style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px;">
          <strong>No available seats found for the selected exam and room.</strong>
        </div>
        <% } %>
        
      </div>
      <div class="clear"></div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>

