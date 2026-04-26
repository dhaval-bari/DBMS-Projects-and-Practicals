
# Transactions

A transaction is a sequence of operations performed as a single logical unit of work.

This section covers transaction management concepts in DBMS including ACID properties, concurrency control, recovery, and real-world implementations.

---

## Topics Covered

* Transaction Basics
* ACID Properties
* Transaction States
* Concurrency Problems
* Serializability
* Lock-Based Protocols & 2PL
* Timestamp-Based Concurrency
* Deadlocks
* Recovery System (WAL, REDO, UNDO)
* Checkpoint & ARIES
* Distributed Transactions (2PC)
* Savepoints
* Modern Databases (MongoDB, MySQL)

---

##  Practical Implementation

VIEW: `transactions_complete.sql`

---

## Concepts

VIEW: `concepts.md`

---

## Objective

To understand how databases ensure consistency, reliability, and fault tolerance in real-world systems.

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
