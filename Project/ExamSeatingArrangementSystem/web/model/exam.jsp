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
		
		results.put("exam_id",request.getParameter("exam_id"));
		results.put("exam_name",request.getParameter("exam_name"));
		results.put("exam_subject",request.getParameter("exam_subject"));
		results.put("exam_date",request.getParameter("exam_date"));
		results.put("exam_start_time",request.getParameter("exam_start_time"));
		results.put("exam_end_time",request.getParameter("exam_end_time"));
		results.put("exam_duration",request.getParameter("exam_duration"));
		results.put("exam_status",request.getParameter("exam_status"));
		results.put("exam_description",request.getParameter("exam_description"));
		
		if((request.getParameter("exam_id")).equals(""))
		{
			out.println(examObj.saveExam(results));
			response.sendRedirect("../report-exam.jsp?emp_id="+emp_id+"&msg=Exam Saved Successfully");
		}
		else
		{
			results.put("exam_id",request.getParameter("exam_id"));
			out.println(examObj.updateExam(results));
			response.sendRedirect("../report-exam.jsp?emp_id=0&msg=Exam Updated Successfully");
		}
	}
%>

