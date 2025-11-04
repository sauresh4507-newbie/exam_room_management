<%@ page import= "java.util.*" %>
<%@ page import= "java.net.URLEncoder" %>
<%@ page import= "Model.*" %>
<%
    response.setContentType("text/csv; charset=UTF-8");
    String filename = "student-seat-report.csv";
    response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

    StudentSeat studentSeatModel = new StudentSeat();
    ArrayList allStudentSeat = studentSeatModel.getAllStudentSeat();

    String searchRollno = request.getParameter("search_rollno");
    String searchName = request.getParameter("search_name");
    String searchRoom = request.getParameter("search_room");

    if(searchRollno != null || searchName != null || searchRoom != null) {
        ArrayList filtered = new ArrayList();
        for(int i=0; i<allStudentSeat.size(); i++) {
            HashMap assignment = (HashMap)allStudentSeat.get(i);
            boolean match = true;

            if(searchRollno != null && !"".equals(searchRollno)) {
                if(!assignment.get("student_rollno").toString().toLowerCase().contains(searchRollno.toLowerCase())) {
                    match = false;
                }
            }
            if(match && searchName != null && !"".equals(searchName)) {
                if(!assignment.get("student_name").toString().toLowerCase().contains(searchName.toLowerCase())) {
                    match = false;
                }
            }
            if(match && searchRoom != null && !"".equals(searchRoom)) {
                if(!assignment.get("room_name").toString().toLowerCase().contains(searchRoom.toLowerCase())) {
                    match = false;
                }
            }
            if(match) {
                filtered.add(assignment);
            }
        }
        allStudentSeat = filtered;
    }

    JspWriter csvOut = out;

    csvOut.println("Roll No,Student Name,Floor,Room,Block,Seat");
    for(int i=0; i<allStudentSeat.size(); i++) {
        HashMap row = (HashMap)allStudentSeat.get(i);

        String rollno = row.get("student_rollno") != null ? row.get("student_rollno").toString() : "";
        String name = row.get("student_name") != null ? row.get("student_name").toString() : "";
        String floor = row.get("floor_name") != null ? row.get("floor_name").toString() : "";
        String room = row.get("room_name") != null ? row.get("room_name").toString() : "";
        String block = row.get("block_name") != null ? row.get("block_name").toString() : "";
        String seat = row.get("seat_number") != null ? row.get("seat_number").toString() : "";

        // Escape double quotes and wrap fields that may contain commas or quotes
        String[] fields = new String[] { rollno, name, floor, room, block, seat };
        StringBuilder line = new StringBuilder();
        for(int f=0; f<fields.length; f++) {
            String value = fields[f] == null ? "" : fields[f];
            boolean needsQuotes = value.indexOf(',') >= 0 || value.indexOf('"') >= 0 || value.indexOf('\n') >= 0 || value.indexOf('\r') >= 0;
            if(value.indexOf('"') >= 0) {
                value = value.replace("\"", "\"\"");
            }
            if(needsQuotes) {
                value = "\"" + value + "\"";
            }
            if(f > 0) line.append(',');
            line.append(value);
        }
        csvOut.println(line.toString());
    }
%>


