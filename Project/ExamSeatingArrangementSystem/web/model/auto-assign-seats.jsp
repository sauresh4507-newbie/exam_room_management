<%@ page import= "Model.*" %>
<%@ page import= "java.util.*" %>

<%
	Exam examObj = new Exam();
	String emp_id = "0";
	if(session.getAttribute("login_level") != null && session.getAttribute("login_level").equals("3")) {
		emp_id = (String) session.getAttribute("login_emp_id");
	}
	if((request.getParameter("act")).equals("Assign"))
	{
		String exam_id = request.getParameter("exam_id");
		String course_id = request.getParameter("course_id");
		
		if(exam_id != null && course_id != null && !course_id.equals("")) {
			String error = examObj.autoAssignSeatsForExam(Integer.parseInt(exam_id), course_id);
			
			if(error.equals("")) {
				response.sendRedirect("../report-exam.jsp?emp_id="+emp_id+"&msg=Seats assigned successfully");
			} else {
				response.sendRedirect("../auto-assign-seats.jsp?exam_id="+exam_id+"&msg=" + error);
			}
		} else {
			response.sendRedirect("../report-exam.jsp?msg=Please select a course");
		}
	}
%>

