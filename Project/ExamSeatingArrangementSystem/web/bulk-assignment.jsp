<%@ include file="includes/header.jsp" %>
<%@ page import= "java.util.*" %>
<%@ page import= "Model.*" %>

<%
	Exam examObj = new Exam();
	StudentSeat seatObj = new StudentSeat();
	Student studentObj = new Student();
	
	ArrayList allExams = examObj.getAllExam();
	ArrayList allStudents = studentObj.getAllStudent();
	
	String exam_id = request.getParameter("exam_id") != null ? request.getParameter("exam_id") : "";
	String[] selectedStudents = request.getParameterValues("selected_students");
	String autoAssign = request.getParameter("auto_assign");
%>
<div class="wrapper row3">
  <div class="rounded">
    <main class="container clear"> 
      <!-- main body --> 
      <div id="comments" style="width: 100%;">
      <h2>Bulk Seat Assignment</h2>
      <div align="center" style="color:#FF0000"><% if(request.getParameter("msg")!=null) out.print(request.getParameter("msg")); %></div><br />
      
        <form action="model/bulk-assignment.jsp" method="post" style="background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-bottom: 20px;">
          <div style="margin-bottom: 20px;">
            <label for="exam_id">Select Exam<span>*</span></label>
            <select style="height: 40px; width:300px; padding: 5px;" name="exam_id" id="exam_id" required>
              <option value="">Select Exam</option>
              <% for(int i=0; i<allExams.size(); i++) {
                  HashMap exam = (HashMap)allExams.get(i);
              %>
                <option value="<%= exam.get("exam_id") %>" <%= exam_id.equals(exam.get("exam_id").toString()) ? "selected" : "" %>>
                  <%= exam.get("exam_name") %> - <%= exam.get("exam_subject") %> (<%= exam.get("exam_date") %>)
                </option>
              <% } %>
            </select>
          </div>
          
          <div style="margin-bottom: 20px;">
            <label>
              <input type="checkbox" name="auto_assign" value="1" <%= autoAssign != null && autoAssign.equals("1") ? "checked" : "" %>>
              Auto-assign available seats (first available seat for each student)
            </label>
          </div>
          
          <h3>Select Students to Assign Seats</h3>
          <div style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
            <table style="width: 100%;">
              <thead>
                <tr style="background-color: #f2f2f2;">
                  <th style="padding: 10px; text-align: left;"><input type="checkbox" id="selectAll" onclick="toggleAll(this)"> Select All</th>
                  <th style="padding: 10px; text-align: left;">Roll Number</th>
                  <th style="padding: 10px; text-align: left;">Student Name</th>
                  <th style="padding: 10px; text-align: left;">Course</th>
                </tr>
              </thead>
              <tbody>
                <% for(int i=0; i<allStudents.size(); i++) {
                    HashMap student = (HashMap)allStudents.get(i);
                    String studentId = student.get("student_id").toString();
                    boolean isSelected = selectedStudents != null && java.util.Arrays.asList(selectedStudents).contains(studentId);
                %>
                  <tr>
                    <td style="padding: 10px;">
                      <input type="checkbox" name="selected_students" value="<%= studentId %>" <%= isSelected ? "checked" : "" %>>
                    </td>
                    <td style="padding: 10px;"><%= student.get("student_rollno") %></td>
                    <td style="padding: 10px;"><%= student.get("student_name") %></td>
                    <td style="padding: 10px;">
                      <% 
                        try {
                          HashMap courseData = new HashMap();
                          String courseName = "N/A";
                          // You can enhance this to get actual course name
                          out.print(courseName);
                        } catch (Exception e) {
                          out.print("N/A");
                        }
                      %>
                    </td>
                  </tr>
                <% } %>
                <% if (allStudents.isEmpty()) { %>
                  <tr>
                    <td colspan="4" style="text-align: center; padding: 20px;">No students found. Please add students first.</td>
                  </tr>
                <% } %>
              </tbody>
            </table>
          </div>
          
          <div style="margin-top: 20px;">
            <input type="submit" value="Assign Seats" style="background-color: #27ae60; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
            <input type="reset" value="Reset" style="background-color: #95a5a6; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px;">
          </div>
          <input type="hidden" name="act" value="bulk_assign" />
        </form>
        
      </div>
      <div class="clear"></div>
    </main>
  </div>
</div>

<script>
function toggleAll(source) {
    var checkboxes = document.getElementsByName('selected_students');
    for(var i=0; i<checkboxes.length; i++) {
        checkboxes[i].checked = source.checked;
    }
}
</script>
<%@ include file="includes/footer.jsp" %>

