-- Additional tables for Exam Management System
-- Run this script after the main esas.sql script

USE esas;

-- Exam/Schedule Management Table
CREATE TABLE IF NOT EXISTS `exam` (
  `exam_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(255) NOT NULL,
  `exam_subject` varchar(255) NOT NULL,
  `exam_date` date NOT NULL,
  `exam_start_time` time NOT NULL,
  `exam_end_time` time NOT NULL,
  `exam_duration` int(11) NOT NULL COMMENT 'Duration in minutes',
  `exam_status` varchar(50) NOT NULL DEFAULT 'Scheduled' COMMENT 'Scheduled, In Progress, Completed, Cancelled',
  `exam_description` text,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- Exam Seat Assignment (Links exam to student_seat)
CREATE TABLE IF NOT EXISTS `exam_seat_assignment` (
  `esa_id` int(11) NOT NULL AUTO_INCREMENT,
  `esa_exam_id` int(11) NOT NULL,
  `esa_student_seat_id` int(11) NOT NULL,
  `esa_status` varchar(50) DEFAULT 'Assigned' COMMENT 'Assigned, Absent, Present',
  `assigned_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`esa_id`),
  FOREIGN KEY (`esa_exam_id`) REFERENCES `exam`(`exam_id`) ON DELETE CASCADE,
  FOREIGN KEY (`esa_student_seat_id`) REFERENCES `student_seat`(`ss_id`) ON DELETE CASCADE,
  UNIQUE KEY `unique_exam_seat` (`esa_exam_id`, `esa_student_seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- Add exam_id to student_seat for better tracking (optional enhancement)
ALTER TABLE `student_seat` 
ADD COLUMN `ss_exam_id` int(11) DEFAULT NULL AFTER `ss_description`,
ADD INDEX `idx_exam_id` (`ss_exam_id`);

-- Sample exam data
INSERT INTO `exam` (`exam_name`, `exam_subject`, `exam_date`, `exam_start_time`, `exam_end_time`, `exam_duration`, `exam_status`, `exam_description`) VALUES
('Midterm Exam 2024', 'Computer Science', '2024-03-15', '09:00:00', '12:00:00', 180, 'Scheduled', 'Midterm examination for all courses'),
('Final Exam Spring 2024', 'Mathematics', '2024-04-20', '14:00:00', '17:00:00', 180, 'Scheduled', 'Final examination for spring semester');

