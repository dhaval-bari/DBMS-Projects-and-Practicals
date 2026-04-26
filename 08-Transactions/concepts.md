# Transaction Concepts

## What is a Transaction?
A transaction is a sequence of operations executed as a single unit.

---

## ACID Properties
- Atomicity → All or nothing  
- Consistency → Valid state maintained  
- Isolation → No interference  
- Durability → Permanent storage  

---

## Transaction States
Active → Partially Committed → Committed  
OR  
Active → Failed → Aborted  

---

## Concurrency Problems
- Dirty Read  
- Lost Update  
- Non-repeatable Read  
- Phantom Read  

---

## Serializability
Ensures transactions execute in a way equivalent to serial execution.

---

## Locks
- Shared Lock (S) → Read  
- Exclusive Lock (X) → Write  

---

## Two-Phase Locking (2PL)
- Growing Phase → Acquire locks  
- Shrinking Phase → Release locks  

---

## Timestamp Ordering
Uses timestamps to control execution order.

---

## Deadlocks
Occurs when transactions wait indefinitely.

---

## Recovery
- REDO → Reapply changes  
- UNDO → Rollback changes  
- WAL → Write-Ahead Logging  

---

## Checkpoint
Reduces recovery time.

---

## Two-Phase Commit (2PC)
Used in distributed systems:
- Prepare phase  
- Commit phase  

---

## Savepoints
Allow partial rollback inside a transaction.

---
