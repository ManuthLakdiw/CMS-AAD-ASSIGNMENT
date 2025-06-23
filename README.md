# 📌 Complaint Management System (CMS)

A web-based Complaint Management System developed as part of the Advanced Application Development (AAD) module. Built using **Jakarta EE (Servlets & JSP)** with **MVC architecture**, and **MySQL** as the backend.

---

## 🚀 Live Demo

🎥 **Video Demo**: [Watch on YouTube](https://youtu.be/hrm_9sukBXA)  
📂 **GitHub Repository**: [CMS-AAD-ASSIGNMENT](https://github.com/ManuthLakdiw/CMS-AAD-ASSIGNMENT)

---

## 🧠 Project Objective

To create a secure and role-based web application where **Employees** can register and submit complaints, and **Admins** can manage and respond to those complaints efficiently.

---

## 💡 Core Features

### 🔐 Sign Up / Sign In

- Employees can register through a sign-up form and log in.
- Admin uses predefined login credentials (no sign-up).
- Role-based redirection and access control.

### 👨‍💻 Employee Dashboard

- View only their own submitted complaints.
- Add new complaints (with title and description).
- Edit or delete complaints before they are resolved.

### 👩‍💼 Admin Dashboard

- View all complaints submitted by all employees.
- See detailed info: employee ID, title, date, status.
- Update complaint status: `In Progress`, `Resolved`, `Rejected`.
- Delete any complaint if needed.

### 🛡️ Session Management & Security

- Session is created at login (`HttpSession`) and validated across pages.
- Unauthorized access is redirected to the Sign-In page.
- Session is invalidated when the user logs out.

---

## 🧱 System Architecture – JSP + Servlet (MVC)

The project follows the **Model-View-Controller** (MVC) pattern:

- **View (JSP)**:  
  All UI pages (Sign Up, Sign In, Dashboards, Tables) are built using JSP. These handle input/output only and avoid business logic.

- **Controller (Servlets)**:  
  Servlets handle user actions like form submissions. They read request parameters, apply validation, and call model logic.

- **Model (JavaBeans + DAO)**:
    - JavaBeans (`ComplaintBean`, `UserBean`) hold data.
    - DAO classes handle DB operations (Insert, Update, Delete, Fetch).


