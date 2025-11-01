<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>
<%@ include file="includes/check_login.jsp" %>

<%
	Exam examObj = new Exam();
	String exam_id = request.getParameter("exam_id");
	
	if(exam_id == null || exam_id.equals("")) {
		response.sendRedirect("report-exam.jsp?msg=Please select an exam");
	}
	
	HashMap examDetails = examObj.getExamDetails(Integer.parseInt(exam_id));
	HashMap availability = examObj.getSeatAvailability(Integer.parseInt(exam_id));
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div id="comments" style="width: 70%; float:left;">
      <h2>Seat Availability for Exam</h2>
      <h3><% out.print(examDetails.get("exam_name")); %> - <% out.print(examDetails.get("exam_subject")); %></h3>
      
      <div style="margin: 20px 0; padding: 15px; background-color: #f9f9f9; border: 1px solid #ddd;">
        <h3>Seat Statistics</h3>
        <table style="width: 100%; margin-top: 10px;">
          <tr>
            <td style="padding: 8px;"><strong>Total Seats:</strong></td>
            <td style="padding: 8px;"><% out.print(availability.get("total_seats")); %></td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>Assigned Seats:</strong></td>
            <td style="padding: 8px;"><% out.print(availability.get("assigned_seats")); %></td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>Available Seats:</strong></td>
            <td style="padding: 8px;"><strong><% out.print(availability.get("available_seats")); %></strong></td>
          </tr>
          <tr>
            <td style="padding: 8px;"><strong>Utilization:</strong></td>
            <td style="padding: 8px;">
              <% 
                int total = (Integer) availability.get("total_seats");
                int assigned = (Integer) availability.get("assigned_seats");
                double utilization = total > 0 ? (assigned * 100.0 / total) : 0;
                out.print(String.format("%.2f", utilization) + "%");
              %>
            </td>
          </tr>
        </table>
      </div>
      
      <div style="margin-top: 20px;">
        <a href="report-exam.jsp">Back to Exams</a>
      </div>
      </div>
      <div style="float: left">
        	<div><img src="images/save_1.jpg" style="width: 250px"></div><br>
        	<div><img src="images/save_2.jpg" style="width: 250px"></div>
        </div>
      <div class="clear"></div>
    </main>
  </div>
</div>
<%@ include file="includes/footer.jsp" %>

