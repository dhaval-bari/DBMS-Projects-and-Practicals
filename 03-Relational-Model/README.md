# Relational Model

This folder demonstrates how ER diagrams are converted into relational database schemas.

It focuses on mapping entities, relationships, and constraints into structured tables using SQL.

---

## Topics Covered

- Entity → Table mapping
- Attributes → Columns
- Primary Keys
- Foreign Keys
- Weak Entities
- Many-to-Many relationship resolution
- Multivalued attributes handling

---

## Case Study Mappings

### University Database
- Weak Entity → SECTION
- M:N Relationship → ENROLLMENT

### Hospital Database
- Associative Entities → ADMISSION, TREATMENT
- Weak Entities → LAB_TEST, EMERGENCY_CONTACT

### E-Commerce Database
- Self-referencing → CATEGORY
- M:N Relationships → ORDER_ITEM, VENDOR_PRODUCT

---

## Purpose

To understand how conceptual ER design is transformed into a logical relational schema used in SQL databases.

---
