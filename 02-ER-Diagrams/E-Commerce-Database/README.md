# 🛒 E-Commerce Database ER Diagram

## Entities

- CUSTOMER (CustID, FirstName, LastName, DateJoined, LoyaltyPoints)
- PRODUCT (ProductID, Name, Description, BasePrice, StockQty, Weight)
- CATEGORY (CatID, CatName, ParentCatID)
- ORDER (OrderID, OrderDate, Status)
- VENDOR (VendorID, Name, Rating, Email, Phone)
- REVIEW (ReviewID, Rating, Comment, Date)

Weak Entities:
- ORDER_ITEM
- ADDRESS

Multivalued:
- CUSTOMER → Email
- PRODUCT → Images

---

## Relationships

- CUSTOMER places ORDER
- ORDER contains PRODUCT (M:N → ORDER_ITEM)
- PRODUCT belongs to CATEGORY
- CATEGORY has hierarchy (self-referencing)
- VENDOR sells PRODUCT (M:N)
- CUSTOMER writes REVIEW for PRODUCT
- ORDER has PAYMENT

---

## Key Concepts Used

- Self-referencing relationship (CATEGORY)
- M:N relationships resolved via:
  - ORDER_ITEM
  - VENDOR_PRODUCT
- Weak entities used for ORDER_ITEM and ADDRESS

---

## ER Diagram
<img width="1701" height="1001" alt="ecommerce_er_diagram" src="https://github.com/user-attachments/assets/1f9960ff-524c-4cb0-a741-b994087802c7" />
