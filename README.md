# Exam-Seating-Arrangement-System-Using-JSP-Servlet
This web project build using Netbeans IDE. Frame Work use Java Servlet and Jsp. Database Mysql.

## 🎉 New Features Added!

This system has been enhanced with several powerful new features:

### ✨ What's New:
1. **Exam/Schedule Management** - Create and manage exams with dates, times, and subjects
2. **Auto Seat Assignment** - Automatically assign seats to students by course
3. **Seat Availability Dashboard** - View real-time seat availability for exams
4. **Statistics Dashboard** - Comprehensive system overview with metrics
5. **Advanced Search** - Multi-criteria search for student seat assignments

See [NEW_FEATURES.md](NEW_FEATURES.md) for detailed documentation.

---

## Installation instructions ==>

1.	install netbeans.(NetBeans IDE 8.0.2) or other version
2.	install mysql database password (apcl123456) that use in project (you can also change project password see point 13,14)
3.	mysql workbench

## Database Configure  ==>

4.	open mysql workbench 
5.	unzip the project folder(ESRS.zip)
6.	open esas.sql from ESRS\DatabaseScript\esas.sql) location
7.	copy all file text and past it in mysql Workbance workspace and run it      
8.	**IMPORTANT**: Now run `DatabaseScript/exam_management_additions.sql` to add new features tables
9.	now esas database is available in database

## Project Configure  ==>

10.	open netbeans IDE
11.	GlassFish server by default add in netbeans, if not add GlassFish server
12.	Open project in netbeans from (ESRS\Project) location
13.	for change database password, host or anything
14.	open Connect Class from com package
15.	now change database configure what you want
16.	compile the project to build new model classes (Exam.java, Statistics.java)
17.	run project.

## Project Login  ==>

18.	username = admin
	password = test

## Quick Start Guide ==>

After login:
1. Click **Dashboard** to see system overview
2. Click **Exam Management** to create and manage exams
3. Click **Auto Assign Seats** from exam list to assign seats automatically
4. Use **Advanced Search** to find specific student seat assignments
5. View **Seat Availability** for any exam to see utilization

## Features Overview ==>

- ✅ Floor, Room, Block, and Seat Management
- ✅ Student Management
- ✅ Employee/User Management  
- ✅ Exam Schedule Management (NEW)
- ✅ Automatic Seat Assignment (NEW)
- ✅ Real-time Statistics Dashboard (NEW)
- ✅ Advanced Search Capabilities (NEW)
- ✅ Seat Availability Tracking (NEW)

For more details, see [NEW_FEATURES.md](NEW_FEATURES.md)

