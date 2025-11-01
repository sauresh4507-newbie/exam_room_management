<%@ page import= "Model.*" %>
<%@ page import= "java.util.*" %>

<%
	Exam examObj = new Exam();
	String emp_id = "0";
	if(session.getAttribute("login_level") != null && session.getAttribute("login_level").equals("3")) {
		emp_id = (String) session.getAttribute("login_emp_id");
	}
	if((request.getParameter("act")).equals("Save"))
	{
		HashMap results = new HashMap();
		
		results.put("exam_id", request.getParameter("exam_id"));
		results.put("exam_name", request.getParameter("exam_name"));
		results.put("exam_subject", request.getParameter("exam_subject"));
		results.put("exam_date", request.getParameter("exam_date"));
		results.put("exam_start_time", request.getParameter("exam_start_time"));
		results.put("exam_end_time", request.getParameter("exam_end_time"));
		results.put("exam_room_id", request.getParameter("exam_room_id") != null && !request.getParameter("exam_room_id").equals("") ? request.getParameter("exam_room_id") : null);
		results.put("exam_course_id", request.getParameter("exam_course_id") != null && !request.getParameter("exam_course_id").equals("") ? request.getParameter("exam_course_id") : null);
		results.put("exam_description", request.getParameter("exam_description"));
		results.put("exam_status", request.getParameter("exam_status"));
		
		if((request.getParameter("exam_id")).equals("") || (request.getParameter("exam_id")).equals("0"))
		{
			out.println(examObj.saveExam(results));
			response.sendRedirect("../report-exam.jsp?msg=Exam Saved Successfully");
		}
		else
		{
			results.put("exam_id", request.getParameter("exam_id"));
			out.println(examObj.updateExam(results));
			response.sendRedirect("../report-exam.jsp?msg=Exam Updated Successfully");
		}
	}
%>

