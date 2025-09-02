-- Seed data for VR Lab Todo Sync Hub
-- Run this after initial migration to populate with sample data

-- Insert additional users
INSERT INTO users (email, name, role, department) VALUES
('student1@yccc.edu', 'Alex Chen', 'student', 'Computer Science'),
('student2@yccc.edu', 'Sarah Johnson', 'student', 'Digital Media'),
('faculty@yccc.edu', 'Dr. Maria Rodriguez', 'faculty', 'Technology Department'),
('brave.williams@yccc.edu', 'Brave Williams', 'collaborator', 'External Partner')
ON CONFLICT (email) DO NOTHING;

-- Insert sample equipment
INSERT INTO equipment (name, model, serial_number, purchase_date, purchase_cost, vendor, status) VALUES
('Meta Quest 3', 'MQ3-128GB', 'MQ3001', '2024-08-15', 499.99, 'Meta Store', 'active'),
('Meta Quest 3', 'MQ3-128GB', 'MQ3002', '2024-08-15', 499.99, 'Meta Store', 'active'),
('Meta Quest 3', 'MQ3-128GB', 'MQ3003', '2024-08-15', 499.99, 'Meta Store', 'maintenance'),
('Dell Precision Workstation', 'T7820', 'DPW001', '2024-01-10', 2499.99, 'Dell Business', 'active'),
('Gaming Laptop', 'ASUS ROG', 'ASUS001', '2023-12-05', 1899.99, 'Best Buy', 'active')
ON CONFLICT (serial_number) DO NOTHING;

-- Insert sample tasks
INSERT INTO tasks (title, description, category, priority, status, created_by, due_date, budget_amount) VALUES
('Setup VR Club orientation session',
 'Prepare introduction materials and demo content for new VR Club members',
 'projects',
 'high',
 'in_progress',
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 '2025-09-15 14:00:00-04',
 0.00),

('Order replacement foam cushions',
 'Current headset cushions showing wear from heavy use',
 'equipment',
 'medium',
 'pending',
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 '2025-09-10 17:00:00-04',
 150.00),

('Weekly equipment maintenance check',
 'Inspect all VR equipment, clean lenses, check battery levels',
 'operations',
 'medium',
 'pending',
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 '2025-09-06 16:00:00-04',
 0.00),

('Submit budget proposal for next semester',
 'Prepare detailed budget request including new equipment and maintenance costs',
 'administrative',
 'high',
 'pending',
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 '2025-09-20 17:00:00-04',
 0.00)
ON CONFLICT DO NOTHING;

-- Insert lab schedule
INSERT INTO lab_schedules (title, description, start_time, end_time, recurring_pattern, instructor_id, max_participants, equipment_needed) VALUES
('VR Development Class',
 'Introduction to VR development using Unity and Meta Quest headsets',
 '2025-09-03 11:00:00-04',
 '2025-09-03 12:15:00-04',
 'weekly',
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 12,
 ARRAY['Meta Quest 3', 'Gaming Laptop']),

('Open Lab Hours',
 'Student access to VR equipment for independent projects',
 '2025-09-03 13:00:00-04',
 '2025-09-03 16:30:00-04',
 'daily',
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 8,
 ARRAY['Meta Quest 3']),

('VR Club Meeting',
 'Weekly VR Club meeting and project showcase',
 '2025-09-04 15:00:00-04',
 '2025-09-04 16:00:00-04',
 'weekly',
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 20,
 ARRAY['Meta Quest 3', 'Projector'])
ON CONFLICT DO NOTHING;

-- Insert some task comments
INSERT INTO task_comments (task_id, user_id, comment) VALUES
((SELECT id FROM tasks WHERE title = 'Purchase 10 additional Meta Quest 3 headsets'),
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 'Researching educational discounts from Meta Direct. Could save 10-15% on bulk purchase.'),

((SELECT id FROM tasks WHERE title = 'Setup VR Club orientation session'),
 (SELECT id FROM users WHERE email = 'john.barr@yccc.edu'),
 'Created demo playlist with 5 different VR experiences. Need to test on all headsets.'),

((SELECT id FROM tasks WHERE title = 'Setup VR Club orientation session'),
 (SELECT id FROM users WHERE email = 'faculty@yccc.edu'),
 'Happy to help with the orientation. Can provide overview of VR in education.')
ON CONFLICT DO NOTHING;