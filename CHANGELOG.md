# Changelog

All notable changes to the Exam Seating Arrangement System project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- CHANGELOG.md file for tracking project changes
- Enhanced code documentation in model classes

### Changed
- Updated README.md with current date (2025-11-12)

## [1.0.0] - 2024

### Added
- **Exam/Schedule Management** - Create and manage exams with dates, times, and subjects
- **Auto Seat Assignment** - Automatically assign seats to students by course
- **Seat Availability Dashboard** - View real-time seat availability for exams
- **Statistics Dashboard** - Comprehensive system overview with metrics
- **Advanced Search** - Multi-criteria search for student seat assignments
- **CSV Export** - Export student seat reports to CSV format
- Database schema additions for exam management (`exam_management_additions.sql`)
- New model classes: `Exam.java`, `Statistics.java`
- Enhanced navigation menu with new feature links
- Dashboard page with system-wide statistics
- Advanced search interface
- Auto-assign seats functionality
- Seat availability tracking

### Changed
- Updated `Model/Floor.java` - Added `getFloorOption` method
- Updated `Model/Room.java` - Added `getRoomOption` method
- Modified `student_seat` table - Added `ss_exam_id` column for exam tracking
- Enhanced `Connect.java` with better error handling and connection management

### Documentation
- Comprehensive README.md with installation instructions
- NEW_FEATURES.md with detailed feature documentation
- Improved JavaDoc comments in model classes
- Added .gitignore for Java/JSP project

## [0.1.0] - Initial Release

### Added
- Basic floor, room, block, and seat management
- Student management system
- Employee/User management
- Seat assignment functionality
- Login and authentication system
- Basic reporting features
- Search seat functionality

---

[Unreleased]: https://github.com/sauresh4507-newbie/exam_room_management/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/sauresh4507-newbie/exam_room_management/releases/tag/v1.0.0
[0.1.0]: https://github.com/sauresh4507-newbie/exam_room_management/releases/tag/v0.1.0

