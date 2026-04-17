# What is NoSQL?

NoSQL stands for "Not Only SQL".

It refers to databases that do not use the traditional table-based relational model.

---

## Key Characteristics

- Schema-less / flexible structure
- Horizontally scalable
- High availability
- Distributed architecture

---

## Example

Unlike relational databases, NoSQL allows storing data in flexible formats like JSON.

---


# Why NoSQL?

Traditional RDBMS struggles with modern data challenges.

---

## The 3 V's of Big Data

- Volume → Huge amount of data
- Velocity → High speed of data generation
- Variety → Different data formats

---

## Limitations of RDBMS

- Rigid schema
- Poor scalability
- Expensive joins
- Single point of failure

---

## NoSQL Solution

- Flexible schema
- Horizontal scaling
- Better performance for large data

---


# CAP Theorem

CAP theorem states that a distributed system can guarantee only two out of three:

- Consistency (C)
- Availability (A)
- Partition Tolerance (P)

---

## Explanation

- Consistency → Same data across all nodes
- Availability → Every request gets a response
- Partition Tolerance → System works despite network failure

---

## Important Insight

In real-world systems, Partition Tolerance is mandatory.

So systems choose between:
- CP (Consistency + Partition)
- AP (Availability + Partition)

---


# Types of NoSQL Databases

There are four main types:

---

## Key-Value Stores
- Example: Redis
- Simple key → value pairs

---

## Document Databases
- Example: MongoDB
- JSON-like documents

---

## Column-Family Databases
- Example: Cassandra
- Data stored in columns

---

## Graph Databases
- Example: Neo4j
- Data stored as nodes and relationships

---


# MongoDB Basics

MongoDB is a document-based NoSQL database.

---

## Structure

- Database → Collection → Document

---

## Example Document

{
  "name": "Rahul",
  "age": 22,
  "city": "Mumbai"
}

---

## Key Features

- Flexible schema
- JSON (BSON) format
- High scalability

---
