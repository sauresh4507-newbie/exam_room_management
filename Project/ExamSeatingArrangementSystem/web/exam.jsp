<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>
<%
	Exam examDetails = new Exam();
	String examLabel = "Save";
	int exam_id = 0;
	if(request.getParameter("exam_id") != null && !request.getParameter("exam_id").equals("")) {
		exam_id = Integer.parseInt(request.getParameter("exam_id"));
		examLabel = "Update";
	}
	HashMap Values = examDetails.getExamDetails(exam_id);	
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div id="comments" style="width: 70%; float:left; margin-right:30px">
      <h2>Exam Entry Form</h2>
      <div align="center" style="color:#FF0000"><% if(request.getParameter("msg")!=null) out.print(request.getParameter("msg")); %></div><br />
        <form action="model/exam.jsp" method="post">
		  <div>
            <label for="exam_name">Exam Name<span>*</span></label>
			<input type="text" name="exam_name" id="exam_name" value="<% out.print(Values.get("exam_name")); %>" size="22" style="width:300px;" required>
          </div>
		  <div>
            <label for="exam_subject">Subject<span>*</span></label>
			<input type="text" name="exam_subject" id="exam_subject" value="<% out.print(Values.get("exam_subject")); %>" size="22" style="width:300px;" required>
          </div>
		  <div>
            <label for="exam_date">Exam Date<span>*</span></label>
			<input type="date" name="exam_date" id="exam_date" value="<% out.print(Values.get("exam_date")); %>" size="22" style="width:300px;" required>
          </div>
		  <div>
            <label for="exam_start_time">Start Time<span>*</span></label>
			<input type="time" name="exam_start_time" id="exam_start_time" value="<% out.print(Values.get("exam_start_time")); %>" size="22" style="width:300px;" required>
          </div>
		  <div>
            <label for="exam_end_time">End Time<span>*</span></label>
			<input type="time" name="exam_end_time" id="exam_end_time" value="<% out.print(Values.get("exam_end_time")); %>" size="22" style="width:300px;" required>
          </div>
		  <div>
            <label for="exam_room_id">Select Room</label>
            <select style="height: 40px; width:300px" name = "exam_room_id" id = "exam_room_id">
                <option value="">Select Room</option>
            	<% out.print(examDetails.getRoomOption(Values.get("exam_room_id") != null && !Values.get("exam_room_id").equals("") ? Integer.parseInt(Values.get("exam_room_id").toString()) : 0)); %>
            </select>
          </div>
		  <div>
            <label for="exam_course_id">Select Course</label>
            <select style="height: 40px; width:300px" name = "exam_course_id" id = "exam_course_id">
                <option value="">Select Course</option>
            	<% out.print(examDetails.getCourseOption(Values.get("exam_course_id") != null && !Values.get("exam_course_id").equals("") ? Integer.parseInt(Values.get("exam_course_id").toString()) : 0)); %>
            </select>
          </div>
		  <div>
            <label for="exam_status">Status<span>*</span></label>
            <select style="height: 40px; width:300px" name = "exam_status" id = "exam_status" required>
                <option value="Scheduled" <% if(Values.get("exam_status").equals("Scheduled")) out.print("selected"); %>>Scheduled</option>
                <option value="In Progress" <% if(Values.get("exam_status").equals("In Progress")) out.print("selected"); %>>In Progress</option>
                <option value="Completed" <% if(Values.get("exam_status").equals("Completed")) out.print("selected"); %>>Completed</option>
                <option value="Cancelled" <% if(Values.get("exam_status").equals("Cancelled")) out.print("selected"); %>>Cancelled</option>
            </select>
          </div>
		  <div>
            <label for="exam_description">Description</label>
			<textarea style="width:300px; height:100px;" name="exam_description"><% out.print(Values.get("exam_description")); %></textarea>
          </div>
          <div class="block clear"></div>
          <div>
            <input name="submit" type="submit" value="<% out.print(examLabel); %> Exam">
            &nbsp;
            <input name="reset" type="reset" value="Reset Form">
          </div>
		  <input type="hidden" name="act" value="Save" />
		  <input type="hidden" name="exam_id" value="<% out.print(Values.get("exam_id")); %>"/>
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

