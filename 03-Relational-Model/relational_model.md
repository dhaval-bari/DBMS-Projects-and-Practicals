## Relational Model

The relational model represents data in the form of tables (relations).

Each table consists of:
- Rows (Tuples)
- Columns (Attributes)

Example:

Student(StudentID, Name, Age)


## Terminology

- Relation → Table
- Tuple → Row
- Attribute → Column
- Domain → Allowed values
- Degree → Number of attributes
- Cardinality → Number of rows


## Relational Schema

Defines structure of a table.

Example:
Student(StudentID, Name, Age)

- StudentID → Primary Key


## Keys in Relational Model

- Primary Key → Unique identifier
- Candidate Key → Possible primary keys
- Alternate Key → Remaining candidate keys
- Foreign Key → Links tables
- Composite Key → Multiple attributes


## Constraints

### Entity Integrity
Primary key cannot be NULL

### Referential Integrity
Foreign key must match primary key in parent table

### Domain Constraint
Values must be valid within domain


## Relational Algebra Operations

- Selection (σ) → Filter rows
- Projection (π) → Select columns
- Union (∪)
- Set Difference (-)
- Cartesian Product (×)
- Join (⨝)

Example:
σ Age > 20 (Student)


## ER to Relational Mapping

### Entity → Table
Student → Students table

### Attribute → Column
Name → Column

### Relationship → Foreign Key
Enrollment → Foreign keys

### Weak Entity
Depends on parent entity

### Multi-valued Attribute
Create separate table


