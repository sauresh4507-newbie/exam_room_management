<%@ page import= "Model.*" %>
<%@ page import= "java.util.*" %>

<%
	StudentSeat seatObj = new StudentSeat();
	String emp_id = "0";
	if(session.getAttribute("login_level") != null && session.getAttribute("login_level").equals("3")) {
		emp_id = (String) session.getAttribute("login_emp_id");
	}
	
	if((request.getParameter("act")).equals("bulk_assign"))
	{
		String exam_id = request.getParameter("exam_id");
		String[] selectedStudents = request.getParameterValues("selected_students");
		String autoAssign = request.getParameter("auto_assign");
		
		if(selectedStudents == null || selectedStudents.length == 0) {
			response.sendRedirect("../bulk-assignment.jsp?exam_id=" + exam_id + "&msg=Please select at least one student");
			return;
		}
		
		int successCount = 0;
		int failCount = 0;
		
		if(autoAssign != null && autoAssign.equals("1")) {
			// Auto-assign: get available seats and assign them
			try {
				// Get all available seats for the exam
				com.Connect.connect_mysql();
				String SQL = "SELECT s.seat_id FROM seat s " +
							"LEFT JOIN student_seat ss ON s.seat_id = ss.ss_seat_id AND (ss.ss_exam_id IS NULL OR ss.ss_exam_id = ?) " +
							"WHERE ss.ss_id IS NULL " +
							"ORDER BY s.seat_id " +
							"LIMIT ?";
				
				java.sql.PreparedStatement pstmt = com.Connect.connection.prepareStatement(SQL);
				pstmt.setString(1, exam_id);
				pstmt.setInt(2, selectedStudents.length);
				java.sql.ResultSet rs = pstmt.executeQuery();
				
				ArrayList seatIds = new ArrayList();
				while(rs.next()) {
					seatIds.add(rs.getString("seat_id"));
				}
				rs.close();
				pstmt.close();
				
				// Assign seats to students
				for(int i = 0; i < selectedStudents.length && i < seatIds.size(); i++) {
					HashMap results = new HashMap();
					results.put("ss_id", "");
					results.put("ss_student_id", selectedStudents[i]);
					results.put("ss_seat_id", seatIds.get(i));
					results.put("ss_exam_id", exam_id);
					results.put("ss_description", "Bulk assigned via auto-assignment");
					
					String error = seatObj.saveStudentSeat(results);
					if(error.equals("")) {
						successCount++;
					} else {
						failCount++;
					}
				}
				
				if(selectedStudents.length > seatIds.size()) {
					failCount += (selectedStudents.length - seatIds.size());
				}
				
			} catch(Exception e) {
				failCount = selectedStudents.length;
				System.out.println("Error in bulk assignment: " + e);
				e.printStackTrace();
			}
		} else {
			// Manual assignment - redirect to individual assignment page
			response.sendRedirect("../student_seat.jsp?ss_id=0&exam_id=" + exam_id);
			return;
		}
		
		String msg = "Bulk assignment completed: " + successCount + " successful, " + failCount + " failed.";
		if(failCount > 0) {
			msg += " Some students could not be assigned seats. Please check seat availability.";
		}
		response.sendRedirect("../report-student-seat.jsp?emp_id=" + emp_id + "&msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
	}
%>

