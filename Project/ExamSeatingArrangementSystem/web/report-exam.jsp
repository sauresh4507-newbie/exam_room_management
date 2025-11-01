<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>

<%
	Exam examDetails = new Exam();
	ArrayList allExam = examDetails.getAllExam();
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div class="scrollable">
        <h2>Exam Report</h2>
		<div style="margin-bottom: 20px;">
			<a href="exam.jsp?exam_id=0" style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Add New Exam</a>
		</div>
		<% if(request.getParameter("msg") != null) { %>
		<div class="msg" style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 20px; border-radius: 5px;"><%=request.getParameter("msg") %></div>
		<% } %>
		
		<!-- Search Form -->
		<form action="report-exam.jsp" method="get" style="background-color: #f8f9fa; padding: 15px; margin-bottom: 20px; border-radius: 5px;">
			<div style="display: flex; gap: 15px; flex-wrap: wrap; align-items: end;">
				<div>
					<label for="search_name">Search by Name/Subject:</label>
					<input type="text" name="search_name" id="search_name" value="<%= request.getParameter("search_name") != null ? request.getParameter("search_name") : "" %>" style="height: 35px; padding: 5px;">
				</div>
				<div>
					<label for="search_status">Status:</label>
					<select name="search_status" id="search_status" style="height: 35px; padding: 5px;">
						<option value="">All</option>
						<option value="Scheduled" <%= "Scheduled".equals(request.getParameter("search_status")) ? "selected" : "" %>>Scheduled</option>
						<option value="In Progress" <%= "In Progress".equals(request.getParameter("search_status")) ? "selected" : "" %>>In Progress</option>
						<option value="Completed" <%= "Completed".equals(request.getParameter("search_status")) ? "selected" : "" %>>Completed</option>
						<option value="Cancelled" <%= "Cancelled".equals(request.getParameter("search_status")) ? "selected" : "" %>>Cancelled</option>
					</select>
				</div>
				<div>
					<label for="search_date_from">Date From:</label>
					<input type="date" name="search_date_from" id="search_date_from" value="<%= request.getParameter("search_date_from") != null ? request.getParameter("search_date_from") : "" %>" style="height: 35px; padding: 5px;">
				</div>
				<div>
					<label for="search_date_to">Date To:</label>
					<input type="date" name="search_date_to" id="search_date_to" value="<%= request.getParameter("search_date_to") != null ? request.getParameter("search_date_to") : "" %>" style="height: 35px; padding: 5px;">
				</div>
				<div>
					<input type="submit" value="Search" style="background-color: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
					<a href="report-exam.jsp" style="background-color: #95a5a6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Reset</a>
				</div>
			</div>
		</form>
		
		<%
			// Filter exams based on search criteria
			String searchName = request.getParameter("search_name");
			String searchStatus = request.getParameter("search_status");
			String searchDateFrom = request.getParameter("search_date_from");
			String searchDateTo = request.getParameter("search_date_to");
			
			if(searchName != null || searchStatus != null || searchDateFrom != null || searchDateTo != null) {
				ArrayList filteredExams = new ArrayList();
				for(int i=0; i<allExam.size(); i++) {
					HashMap exam = (HashMap)allExam.get(i);
					boolean match = true;
					
					if(searchName != null && !searchName.equals("")) {
						String name = exam.get("exam_name").toString().toLowerCase() + " " + exam.get("exam_subject").toString().toLowerCase();
						if(!name.contains(searchName.toLowerCase())) {
							match = false;
						}
					}
					
					if(match && searchStatus != null && !searchStatus.equals("")) {
						if(!exam.get("exam_status").toString().equals(searchStatus)) {
							match = false;
						}
					}
					
					if(match && searchDateFrom != null && !searchDateFrom.equals("")) {
						if(exam.get("exam_date").toString().compareTo(searchDateFrom) < 0) {
							match = false;
						}
					}
					
					if(match && searchDateTo != null && !searchDateTo.equals("")) {
						if(exam.get("exam_date").toString().compareTo(searchDateTo) > 0) {
							match = false;
						}
					}
					
					if(match) {
						filteredExams.add(exam);
					}
				}
				allExam = filteredExams;
			}
		%>
		
        <table style="width: 100%; border-collapse: collapse;">
          <thead>
            <tr style="background-color: #f2f2f2;">
              <th style="padding: 10px; border: 1px solid #ddd;">Exam Name</th>
			  <th style="padding: 10px; border: 1px solid #ddd;">Subject</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Date</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Time</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Room</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Course</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Status</th>
              <th style="padding: 10px; border: 1px solid #ddd;">Action</th>
            </tr>
          </thead>
          <tbody>
			<% for(int i=0;i<allExam.size();i++) 
			{ 
				HashMap ExamDetails = new HashMap();
				ExamDetails = (HashMap)allExam.get(i);
			%>
				<tr>
				  <td style="text-align:center; padding: 10px; border: 1px solid #ddd;"><% out.print(ExamDetails.get("exam_name")); %></td>
				  <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(ExamDetails.get("exam_subject")); %></td>
				  <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(ExamDetails.get("exam_date")); %></td>
				  <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(ExamDetails.get("exam_start_time") + " - " + ExamDetails.get("exam_end_time")); %></td>
				  <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(ExamDetails.get("room_name")); %></td>
				  <td style="padding: 10px; border: 1px solid #ddd;"><% out.print(ExamDetails.get("course_name")); %></td>
				  <td style="padding: 10px; border: 1px solid #ddd;">
					<span style="padding: 5px 10px; border-radius: 3px; background-color: 
					<% 
						String status = ExamDetails.get("exam_status").toString();
						if(status.equals("Scheduled")) out.print("#3498db");
						else if(status.equals("In Progress")) out.print("#f39c12");
						else if(status.equals("Completed")) out.print("#27ae60");
						else out.print("#e74c3c");
					%>; color: white;">
					<% out.print(status); %>
					</span>
				  </td>
				  <td style="padding: 10px; border: 1px solid #ddd;"> 
					<a href="exam.jsp?exam_id=<% out.print(ExamDetails.get("exam_id")); %>" style="color: #0066cc;">Edit</a> | 
					<a href="exam-seating.jsp?exam_id=<% out.print(ExamDetails.get("exam_id")); %>" style="color: #0066cc;">Assign Seats</a>
				  </td>
				</tr>
			<%
			}
			if(allExam.size() == 0) 
			{
			%>
				<tr>
					<td colspan="8" style="text-align: center; padding: 20px;">No Records Found !!!</td>
				</tr>
			<%
			}
			%>
          </tbody>
        </table>
        <div style="margin-top: 15px; color: #666;">
          Total Records: <%= allExam.size() %>
        </div>
        </div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>

