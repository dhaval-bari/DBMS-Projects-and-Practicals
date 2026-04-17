
# Transactions

A transaction is a sequence of operations performed as a single logical unit of work.

---

## ACID Properties

### Atomicity
- All operations succeed or none are applied

### Consistency
- Database remains valid before and after transaction

### Isolation
- Transactions do not interfere with each other

### Durability
- Changes are permanently stored

---

## Purpose

- Ensure data integrity
- Handle failures safely
- Support concurrent users

---

## Example

Bank transfer:
- Debit from Account A
- Credit to Account B

Both must succeed together.

---
