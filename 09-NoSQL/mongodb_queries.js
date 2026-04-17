// Create Database
use collegeDB;

// Insert document
db.students.insertOne({
  name: "Rahul",
  age: 22,
  course: "FinTech"
});

// Find documents
db.students.find();

// Update document
db.students.updateOne(
  { name: "Rahul" },
  { $set: { age: 23 } }
);

// Delete document
db.students.deleteOne({ name: "Rahul" });
