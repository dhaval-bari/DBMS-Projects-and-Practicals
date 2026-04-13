-- Example: ER → Relational Mapping (University)

-- ENTITY → TABLE
CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100)
);

-- WEAK ENTITY
CREATE TABLE SECTION (
    CourseCode VARCHAR(10),
    SectionNo INT,
    PRIMARY KEY (CourseCode, SectionNo)
);

-- MULTIVALUED ATTRIBUTE
CREATE TABLE STUDENT_EMAIL (
    StudentID INT,
    Email VARCHAR(100),
    PRIMARY KEY (StudentID, Email)
);

-- M:N RELATIONSHIP
CREATE TABLE ENROLLMENT (
    StudentID INT,
    CourseCode VARCHAR(10),
    PRIMARY KEY (StudentID, CourseCode)
);
