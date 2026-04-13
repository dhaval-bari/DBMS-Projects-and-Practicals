-- BEFORE (Not in 1NF)
-- Student(Name, Subjects)
-- Subjects = "Math, Science" ❌

-- AFTER (1NF)
CREATE TABLE Student_1NF (
    Name VARCHAR(100),
    Subject VARCHAR(100)
);

-- Each row contains only one subject
