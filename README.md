# Exam-Seating-Arrangement-System-Using-JSP-Servlet
Last updated: 2025-11-04

This web project is built using NetBeans IDE. Framework uses Java Servlet and JSP. Database: MySQL.

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

## Installation Instructions

1. Install NetBeans IDE (NetBeans IDE 8.0.2 or other version)
2. Install MySQL database with password (apcl123456) that is used in the project (you can also change project password - see points 13,14)
3. Install MySQL Workbench

## Database Configuration

4. Open MySQL Workbench 
5. Unzip the project folder (ESRS.zip)
6. Open `esas.sql` from `ESRS\DatabaseScript\esas.sql` location
7. Copy all file text and paste it in MySQL Workbench workspace and run it      
8. **IMPORTANT**: Now run `DatabaseScript/exam_management_additions.sql` to add new features tables
9. Now `esas` database is available in the database

## Project Configuration

10. Open NetBeans IDE
11. GlassFish server is added by default in NetBeans, if not add GlassFish server
12. Open project in NetBeans from `ESRS\Project` location
13. To change database password, host or anything:
14. Open Connect Class from `com` package
15. Now change database configuration as you want
16. Compile the project to build new model classes (Exam.java, Statistics.java)
17. Run project

## Project Login

**Username:** admin  
**Password:** test

## Quick Start Guide

After login:
1. Click **Dashboard** to see system overview
2. Click **Exam Management** to create and manage exams
3. Click **Auto Assign Seats** from exam list to assign seats automatically
4. Use **Advanced Search** to find specific student seat assignments
5. View **Seat Availability** for any exam to see utilization

## Features Overview

- ✅ Floor, Room, Block, and Seat Management
- ✅ Student Management
- ✅ Employee/User Management
- ✅ Exam Schedule Management (NEW)
- ✅ Automatic Seat Assignment (NEW)
- ✅ Real-time Statistics Dashboard (NEW)
- ✅ Advanced Search Capabilities (NEW)
- ✅ Seat Availability Tracking (NEW)

For more details, see [NEW_FEATURES.md](NEW_FEATURES.md)
