<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>
<%@ include file="includes/check_login.jsp" %>

<%
	Exam examObj = new Exam();
	HashMap examDetails = new HashMap();
	String exam_id = request.getParameter("exam_id");
	if(exam_id != null && !exam_id.equals(""))
	{
		examDetails = examObj.getExamDetails(Integer.parseInt(exam_id));
	}
	else
	{
		examDetails.put("exam_id", "");
		examDetails.put("exam_name", "");
		examDetails.put("exam_subject", "");
		examDetails.put("exam_date", "");
		examDetails.put("exam_start_time", "");
		examDetails.put("exam_end_time", "");
		examDetails.put("exam_duration", "");
		examDetails.put("exam_status", "Scheduled");
		examDetails.put("exam_description", "");
	}
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div id="comments" style="width: 70%; float:left;">
      <h2>Add/Edit Exam</h2>
        <form action="model/exam.jsp" method="post">
          <div id="emp_id">
            <label for="exam_name">Exam Name:<span>*</span></label>
            <input type="text" name="exam_name" id="exam_name" value="<%= examDetails.get("exam_name") %>" size="22" style="width:300px;" required>
          </div>
          <div class="clear"></div>
          <div id="emp_id">
            <label for="exam_subject">Subject:<span>*</span></label>
            <input type="text" name="exam_subject" id="exam_subject" value="<%= examDetails.get("exam_subject") %>" size="22" style="width:300px;" required>
          </div>
          <div class="clear"></div>
          <div id="emp_id">
            <label for="exam_date">Exam Date:<span>*</span></label>
            <input type="date" name="exam_date" id="exam_date" value="<%= examDetails.get("exam_date") %>" size="22" style="width:300px;" required>
          </div>
          <div class="clear"></div>
          <div id="emp_id">
            <label for="exam_start_time">Start Time:<span>*</span></label>
            <input type="time" name="exam_start_time" id="exam_start_time" value="<%= examDetails.get("exam_start_time") %>" size="22" style="width:300px;" required>
          </div>
          <div class="clear"></div>
          <div id="emp_id">
            <label for="exam_end_time">End Time:<span>*</span></label>
            <input type="time" name="exam_end_time" id="exam_end_time" value="<%= examDetails.get("exam_end_time") %>" size="22" style="width:300px;" required>
          </div>
          <div class="clear"></div>
          <div id="emp_id">
            <label for="exam_duration">Duration (minutes):<span>*</span></label>
            <input type="number" name="exam_duration" id="exam_duration" value="<%= examDetails.get("exam_duration") %>" size="22" style="width:300px;" required>
          </div>
          <div class="clear"></div>
          <div id="emp_id">
            <label for="exam_status">Status:<span>*</span></label>
            <select name="exam_status" id="exam_status" style="width:300px;" required>
              <option value="Scheduled" <%= examDetails.get("exam_status").equals("Scheduled") ? "selected" : "" %>>Scheduled</option>
              <option value="In Progress" <%= examDetails.get("exam_status").equals("In Progress") ? "selected" : "" %>>In Progress</option>
              <option value="Completed" <%= examDetails.get("exam_status").equals("Completed") ? "selected" : "" %>>Completed</option>
              <option value="Cancelled" <%= examDetails.get("exam_status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
            </select>
          </div>
          <div class="clear"></div>
          <div id="emp_id">
            <label for="exam_description">Description:</label>
            <textarea name="exam_description" id="exam_description" rows="4" style="width:300px;"><%= examDetails.get("exam_description") %></textarea>
          </div>
          <div class="clear"></div>
          <div>
            <input name="submit" type="submit" value="Save">
            &nbsp;
            <input name="reset" type="reset" value="Reset Form">
            &nbsp;
            <a href="report-exam.jsp">Cancel</a>
          </div>
          <input type="hidden" name="exam_id" value="<%= examDetails.get("exam_id") %>" />
          <input type="hidden" name="act" value="Save" />
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

