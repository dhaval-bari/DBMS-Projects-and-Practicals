# 🎓 University Database ER Diagram

## Entities (from case study)

- STUDENT (StudentID, FirstName, LastName, DOB, Gender, GPA)
- COURSE (CourseCode, Title, Credits, Description)
- SECTION (Weak Entity of COURSE)
- INSTRUCTOR (EmpID, Name, Title, Salary)
- DEPARTMENT (DeptID, DeptName, Location)

Multivalued attributes:
- STUDENT → Email
- INSTRUCTOR → PhoneNo

---

## Relationships

- STUDENT enrolls in SECTION (M:N)
- SECTION taught by INSTRUCTOR (N:1)
- SECTION belongs to COURSE (Weak Entity)
- COURSE belongs to DEPARTMENT
- INSTRUCTOR works in DEPARTMENT
- INSTRUCTOR manages DEPARTMENT (1:1)

---

## Key Concepts Used

- Weak Entity → SECTION
- Multivalued attributes handled separately
- Many-to-Many resolved using ENROLLMENT

---

## ER Diagram
<img width="1072" height="601" alt="University ER Diagrams drawio" src="https://github.com/user-attachments/assets/bc46370a-1948-4be1-bf8d-8af081e7ae96" />
