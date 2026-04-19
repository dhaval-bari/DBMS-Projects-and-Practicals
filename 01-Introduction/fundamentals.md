## Data vs Information

| Data                     | Information           |
|--------------------------|-----------------------|
| Raw facts                | Processed, meaningful |
| No context               | Contextual            |
| Cannot support decisions | Supports decisions    |

### Example
Data: 7842901, ₹1499, MH → DEL  
Information: Order placed for ₹1499 from Maharashtra to Delhi

### Pipeline
Data → Processing → Information → Decision


## File System vs DBMS

| Feature      | File System   | DBMS           |
|--------------|---------------|----------------|
| Redundancy   | High          | Low            |
| Consistency  | Poor          | High           |
| Security     | Basic         | Advanced       |
| Transactions | Not supported | ACID compliant |
| Querying     | Difficult     | SQL            |

### Key Problems Solved by DBMS
- Data redundancy
- Data inconsistency
- Lack of security
- No transactions


## What is DBMS?

A DBMS is software that manages databases and allows users to store, retrieve, and manipulate data efficiently.

### Functions
- Defining (schema)
- Constructing (storage)
- Manipulating (queries)
- Sharing (multi-user access)


## 3-Schema Architecture

1. External Level → User View  
2. Conceptual Level → Logical Design  
3. Internal Level → Physical Storage  

### Data Independence
- Physical → Storage changes don’t affect design  
- Logical → Design changes don’t affect users  

### Deployment Types
- 1-Tier → Local system  
- 2-Tier → Client-server  
- 3-Tier → Web apps (modern systems)


## Data Models

- Hierarchical → Tree structure  
- Network → Graph structure  
- Relational → Tables (MOST IMPORTANT)  
- Object-Oriented → Complex data  
- NoSQL → Flexible schema  

### Industry Standard
Relational Model (SQL-based systems)


## ER Model

### Components
- Entity → Object (Student, Product)
- Attribute → Properties (Name, Age)
- Relationship → Connection (Student enrolls Course)

### Types of Attributes
- Simple
- Composite
- Multi-valued
- Derived
- Key

### Cardinality
- 1:1
- 1:N
- M:N


## Types of Keys

- Super Key → Any unique combination  
- Candidate Key → Minimal unique key  
- Primary Key → Selected unique key  
- Alternate Key → Remaining candidate keys  
- Foreign Key → Links tables  
- Composite Key → Multiple attributes  
- Surrogate Key → Artificial key (ID)


## Normalization

### Goal
Reduce redundancy and improve data integrity

### Normal Forms

1NF → Atomic values  
2NF → No partial dependency  
3NF → No transitive dependency  

### Rule
"Every non-key attribute depends on the key"
