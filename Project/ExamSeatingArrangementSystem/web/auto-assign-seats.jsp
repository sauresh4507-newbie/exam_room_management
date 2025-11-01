<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>
<%@ include file="includes/check_login.jsp" %>

<%
	Exam examObj = new Exam();
	Student studentObj = new Student();
	
	String exam_id = request.getParameter("exam_id");
	String course_id = request.getParameter("course_id");
	String msg = request.getParameter("msg");
	
	if(exam_id == null || exam_id.equals("")) {
		response.sendRedirect("report-exam.jsp?msg=Please select an exam");
	}
	
	HashMap examDetails = examObj.getExamDetails(Integer.parseInt(exam_id));
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div id="comments" style="width: 70%; float:left;">
      <h2>Auto Assign Seats for Exam</h2>
      <h3><% out.print(examDetails.get("exam_name")); %> - <% out.print(examDetails.get("exam_subject")); %></h3>
      
		<% if(msg != null) { %>
		<div class="msg"><%=msg %></div>
		<% } %>
		
        <form action="model/auto-assign-seats.jsp" method="post">
          <div id="emp_id">
            <label for="course_id">Select Course:<span>*</span></label>
            <select name="course_id" id="course_id" style="width:300px;" required>
              <option value="">-- Select Course --</option>
              <%= studentObj.getCourseOption(0) %>
            </select>
          </div>
          <div class="clear"></div>
          <p style="margin: 15px 0; padding: 10px; background-color: #f0f0f0;">
            <strong>Note:</strong> This will automatically assign available seats to all students in the selected course for this exam.
            Students will be assigned seats in sequential order.
          </p>
          <div class="clear"></div>
          <div>
            <input name="submit" type="submit" value="Auto Assign Seats">
            &nbsp;
            <a href="report-exam.jsp">Cancel</a>
          </div>
          <input type="hidden" name="exam_id" value="<%= exam_id %>" />
          <input type="hidden" name="act" value="Assign" />
        </form>
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

