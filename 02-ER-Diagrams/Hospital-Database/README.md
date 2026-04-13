# 🏥 Hospital Database ER Diagram

## Entities

- PATIENT (PatientID, Name, DOB, BloodType, Address)
- DOCTOR (DoctorID, Name, Specialization, Contact, Experience)
- NURSE (NurseID, Name, Shift)
- WARD (WardID, WardName, FloorNo, Capacity)
- MEDICATION (DrugID, Name, Manufacturer, Type)
- LAB_TEST (Weak Entity of PATIENT)

Weak Entities:
- LAB_TEST
- EMERGENCY_CONTACT

---

## Relationships

- PATIENT admitted to WARD (M:N)
- PATIENT treated by DOCTOR (M:N)
- DOCTOR prescribes MEDICATION (M:N)
- NURSE assigned to WARD (N:1)
- NURSE manages WARD (1:1)
- PATIENT has LAB_TEST (1:N)
- LAB_TEST ordered by DOCTOR
- PATIENT has EMERGENCY_CONTACT

---

## Key Concepts Used

- Weak Entities (LAB_TEST, EMERGENCY_CONTACT)
- Associative Entities (ADMISSION, TREATMENT, PRESCRIPTION)
- Complex Relationships (M:N resolved into tables)

---

## ER Diagram
<img width="1198" height="883" alt="hospital_er_diagram" src="https://github.com/user-attachments/assets/72277b4a-fe12-43c5-9004-7c0d4cb81b75" />
