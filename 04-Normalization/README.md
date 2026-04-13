# Normalization

Normalization is the process of organizing data to reduce redundancy and improve data integrity.

---

## Types of Normal Forms

### 1NF (First Normal Form)
- No repeating groups
- Atomic values (no multiple values in a single column)

### 2NF (Second Normal Form)
- Must be in 1NF
- No partial dependency (non-key depends on full primary key)

### 3NF (Third Normal Form)
- Must be in 2NF
- No transitive dependency (non-key depends only on primary key)

---

## Purpose

- Reduce data redundancy
- Improve data consistency
- Avoid update anomalies
- Ensure efficient database design

---

## Approach

Each example shows:
1. Unnormalized table ❌  
2. Step-by-step normalization ✅  

---
