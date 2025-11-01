<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>
<%@ include file="includes/check_login.jsp" %>

<%
	Exam examDetails = new Exam();
	String employeeID = "0";
	ArrayList allExam = examDetails.getAllExam();
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div class="scrollable">
        <h2>Exam Report</h2>
		<% if(request.getParameter("msg") != null) { %>
		<div class="msg"><%=request.getParameter("msg") %></div>
		<% } %>
        <table>
          <thead>
            <tr>
              <th>Exam Name</th>
              <th>Subject</th>
              <th>Date</th>
              <th>Time</th>
              <th>Duration</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
			<% for(int i=0;i<allExam.size();i++) 
			{ 
				HashMap ExamDetails = new HashMap();
				ExamDetails = (HashMap)allExam.get(i);
			%>
				<tr>
				  <td style="text-align:center;"><% out.print(ExamDetails.get("exam_name")); %></td>
				  <td><% out.print(ExamDetails.get("exam_subject")); %></td>
				  <td><% out.print(ExamDetails.get("exam_date")); %></td>
				  <td><% out.print(ExamDetails.get("exam_start_time") + " - " + ExamDetails.get("exam_end_time")); %></td>
				  <td><% out.print(ExamDetails.get("exam_duration") + " min"); %></td>
				  <td><% out.print(ExamDetails.get("exam_status")); %></td>
				  <td> 
					<a href="exam.jsp?exam_id=<% out.print(ExamDetails.get("exam_id")); %>">Edit</a>
					&nbsp;|&nbsp;
					<a href="auto-assign-seats.jsp?exam_id=<% out.print(ExamDetails.get("exam_id")); %>">Assign Seats</a>
					&nbsp;|&nbsp;
					<a href="exam-availability.jsp?exam_id=<% out.print(ExamDetails.get("exam_id")); %>">View Availability</a>
				  </td>
				</tr>
			<%
			}
			if(allExam.size() == 0) 
			{
			%>
				<tr>
					<td colspan="7">No Records Found !!!</td>
				</tr>
			<%
			}
			%>
          </tbody>
        </table>
		<div style="margin-top: 20px;">
			<a href="exam.jsp">Add New Exam</a>
		</div>
      </div>
      <div class="clear"></div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>

