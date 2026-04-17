# 📋 Complaint Management System (CMS)

<div align="center">

![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=java)
![Jakarta EE](https://img.shields.io/badge/Jakarta_EE-Servlets_%26_JSP-blue?style=for-the-badge&logo=jakarta)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![Maven](https://img.shields.io/badge/Maven-Build_Tool-red?style=for-the-badge&logo=apachemaven)
![TailwindCSS](https://img.shields.io/badge/TailwindCSS-CDN-38B2AC?style=for-the-badge&logo=tailwind-css)
![Tomcat](https://img.shields.io/badge/Apache_Tomcat-10+-yellow?style=for-the-badge&logo=apachetomcat)

A role-based, web-based **Complaint Management System** developed as part of the **Advanced Application Development (AAD)** module at IJSE. Built with **Jakarta EE (Servlets & JSP)**, following the **MVC architecture**, and powered by **MySQL**.

[🎥 Video Demo](https://youtu.be/hrm_9sukBXA) · [📂 GitHub Repository](https://github.com/ManuthLakdiw/CMS-AAD-ASSIGNMENT) · [🐛 Report Bug](https://github.com/ManuthLakdiw/CMS-AAD-ASSIGNMENT/issues)

</div>

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Features](#-features)
- [System Architecture](#-system-architecture--mvc)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Database Schema](#-database-schema)
- [API / Servlet Endpoints](#-api--servlet-endpoints)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Database Setup](#1-database-setup)
  - [Configure the DataSource](#2-configure-the-datasource)
  - [Build & Deploy](#3-build--deploy)
- [Default User Credentials](#-default-user-credentials)
- [Screenshots / Pages](#-application-pages)
- [Dependencies](#-dependencies)
- [Author](#-author)

---

## 🎯 Project Overview

The **Complaint Management System (CMS)** is a secure, session-based web application that allows:

- **Employees** to register, log in, and manage their own complaints (submit, edit, delete).
- **Admins** to view all complaints from all employees and update their statuses (In Progress, Resolved, Rejected).

It enforces strict **role-based access control** (RBAC) using server-side session validation, ensuring users can only access the resources relevant to their role.

---

## 💡 Features

### 🔐 Authentication & Authorization

| Feature | Details |
|---|---|
| Sign Up | Employees can self-register with name, email, username, and password |
| Sign In | Both admins and employees log in via username and password |
| Password Security | Passwords are hashed using **BCrypt** (`jbcrypt`) before storage |
| Session Management | `HttpSession` is created on login and validated on every protected request |
| Role-Based Routing | Employees → Employee Dashboard; Admins → Admin Dashboard |
| Logout | Session is fully invalidated on logout |
| Unauthorized Access | All protected pages redirect unauthenticated users to the Sign In page |

---

### 👨‍💻 Employee Features

| Feature | Details |
|---|---|
| View Own Complaints | Employees see only their own submitted complaints |
| Submit Complaint | Form with title and description fields; auto-generates ID, date, and time |
| Edit Complaint | Edit any complaint that is still in **Pending** status |
| Delete Complaint | Remove any personal complaint |
| Status Visibility | Employees can see the live status of each complaint (Pending / In Progress / Resolved / Rejected) |

---

### 👩‍💼 Admin Features

| Feature | Details |
|---|---|
| View All Complaints | Full list of all complaints from every employee |
| Complaint Details | Employee ID, title, description, submission date/time, and current status |
| Update Status | Set status to `In Progress`, `Resolved`, or `Rejected` |
| Delete Any Complaint | Admin can remove any complaint |
| Employee Directory | A dedicated view to see all registered employees |

---

## 🏛 System Architecture – MVC

The project strictly follows the **Model-View-Controller (MVC)** design pattern:

```
┌─────────────────────────────────────────────────────────────────┐
│                         BROWSER (CLIENT)                        │
│                   HTTP Request / HTTP Response                  │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    CONTROLLER (Servlets)                        │
│  SignInServlet · SignUpServlet · ComplaintServlet               │
│  EmployeeViewServlet · LogoutServlet                            │
│  - Handles HTTP GET/POST                                        │
│  - Validates sessions & roles                                   │
│  - Delegates to DAO layer                                       │
│  - Forwards/Redirects to JSP Views                             │
└────────────┬───────────────────────────────┬────────────────────┘
             │                               │
┌────────────▼────────────┐   ┌─────────────▼──────────────────┐
│      MODEL (DAO)        │   │         VIEW (JSP)              │
│  UserDao · ComplaintDao │   │  index.jsp · signin.jsp        │
│  - CRUD via CrudUtil    │   │  signup.jsp · adminDashboard   │
│  - MySQL via DBCP2 pool │   │  employeeDashBoard.jsp         │
│                         │   │  viewAllEmployee.jsp           │
└────────────┬────────────┘   └────────────────────────────────┘
             │
┌────────────▼────────────┐
│      BEANS (Entities)   │
│  UserBean · ComplaintBean│
└─────────────────────────┘
             │
┌────────────▼────────────┐
│   DATABASE (MySQL)      │
│   Tables: user, complaint│
└─────────────────────────┘
```

### Key Architectural Components

| Layer | Class(es) | Responsibility |
|---|---|---|
| **View** | `*.jsp` files | Renders HTML UI, reads request attributes |
| **Controller** | `*Servlet.java` files | Processes HTTP requests, calls DAO, manages session |
| **Model (Bean)** | `UserBean`, `ComplaintBean` | Plain data objects (POJOs with Lombok) |
| **Model (DAO)** | `UserDao`, `ComplaintDao` | All SQL operations (INSERT, SELECT, UPDATE, DELETE) |
| **Utility** | `CrudUtil` | Generic `PreparedStatement` executor |
| **Listener** | `ContextListener` | Initializes DBCP2 connection pool on app startup |

---

## 🛠 Tech Stack

| Category | Technology | Version |
|---|---|---|
| Language | Java | 21 |
| Web Framework | Jakarta EE (Servlet API) | 6.1.0-M2 |
| View Technology | JSP (JavaServer Pages) | Servlet container-supplied |
| Frontend Styling | TailwindCSS (CDN) | Latest |
| Build Tool | Apache Maven | 3.x |
| Application Server | Apache Tomcat | 10+ |
| Database | MySQL | 8.0+ |
| DB Connection Pool | Apache Commons DBCP2 | 2.13.0 |
| MySQL Driver | MySQL Connector/J | 9.2.0 |
| Utility | Lombok | 1.18.36 |
| Password Hashing | jBCrypt | 0.4 |

---

## 📁 Project Structure

```
CMS/
├── pom.xml                                  # Maven build configuration
├── README.md
│
├── src/
│   └── main/
│       ├── db/
│       │   └── schema.sql                   # Database creation + seed data
│       │
│       └── java/
│           ├── listner/
│           │   └── ContextListener.java     # @WebListener: DBCP2 pool init/destroy
│           │
│           ├── util/
│           │   └── CrudUtil.java            # Generic PreparedStatement executor
│           │
│           └── lk/ijse/
│               ├── controller/
│               │   ├── ComplaintServlet.java    # @WebServlet("/complaint")
│               │   ├── EmployeeViewServlet.java # @WebServlet("/employees")
│               │   ├── LogoutServlet.java       # @WebServlet("/logout")
│               │   ├── SignInServlet.java       # @WebServlet("/signin")
│               │   └── SignUpServlet.java       # @WebServlet("/signup")
│               │
│               └── model/
│                   ├── bean/
│                   │   ├── ComplaintBean.java   # Complaint entity (Lombok)
│                   │   └── UserBean.java        # User entity (Lombok)
│                   └── dao/
│                       ├── ComplaintDao.java    # Complaint CRUD operations
│                       └── UserDao.java         # User CRUD operations
│
└── web/
    ├── index.jsp                            # Landing page (Login / Sign Up links)
    ├── js/                                  # Client-side JavaScript assets
    ├── META-INF/
    └── WEB-INF/
        └── web.xml                          # Deployment descriptor (welcome file)
    └── view/
        ├── signin.jsp                       # Login page
        ├── signup.jsp                       # Employee registration page
        ├── adminDashboard.jsp               # Admin: view & manage all complaints
        ├── employeeDashBoard.jsp            # Employee: view & manage own complaints
        └── viewAllEmployee.jsp              # Admin: view all registered employees
```

---

## 🗄 Database Schema

The database is named **`CMS`** and consists of two tables.

### `user` Table

```sql
CREATE TABLE user (
    id        VARCHAR(10)  PRIMARY KEY,   -- Format: US00-001
    name      VARCHAR(100),
    email     VARCHAR(100),
    user_name VARCHAR(50),
    password  VARCHAR(100),               -- BCrypt hashed
    role      VARCHAR(20)                 -- 'admin' or 'employee'
);
```

### `complaint` Table

```sql
CREATE TABLE complaint (
    id          VARCHAR(10)  PRIMARY KEY,  -- Auto-generated
    employee_id VARCHAR(10),
    title       VARCHAR(200),
    description TEXT,
    date        DATE,
    time        TIME,
    status      VARCHAR(50),               -- Pending / In Progress / Resolved / Rejected
    FOREIGN KEY (employee_id) REFERENCES user(id)
);
```

### Entity Relationship

```
user (1) ──────< complaint (many)
  id ──────────── employee_id (FK)
```

---

## 🔗 API / Servlet Endpoints

| HTTP Method | URL Pattern | Servlet | Description |
|---|---|---|---|
| `GET` | `/` | `index.jsp` | Landing page |
| `GET` | `/view/signin.jsp` | — | Sign In page |
| `POST` | `/signin` | `SignInServlet` | Authenticate user, create session |
| `GET` | `/view/signup.jsp` | — | Sign Up page |
| `POST` | `/signup` | `SignUpServlet` | Register new employee |
| `GET` | `/complaint` | `ComplaintServlet` | Load Employee or Admin dashboard |
| `POST` | `/complaint?action=ADD` | `ComplaintServlet` | Submit a new complaint |
| `POST` | `/complaint?action=UPDATE` | `ComplaintServlet` | Edit an existing complaint |
| `POST` | `/complaint?action=DELETE` | `ComplaintServlet` | Delete a complaint |
| `POST` | `/complaint?action=RESOLVE` | `ComplaintServlet` | Admin updates complaint status |
| `GET` | `/complaint?action=edit&id=...` | `ComplaintServlet` | Load edit form for a complaint |
| `GET` | `/employees` | `EmployeeViewServlet` | Admin: view all employees |
| `GET` | `/logout` | `LogoutServlet` | Invalidate session, redirect to sign-in |

---

## 🚀 Getting Started

### Prerequisites

Before running this project, make sure you have the following installed:

| Tool | Version | Download |
|---|---|---|
| JDK | 21+ | [Adoptium](https://adoptium.net/) |
| Apache Maven | 3.6+ | [Maven Downloads](https://maven.apache.org/download.cgi) |
| Apache Tomcat | 10.x+ | [Tomcat Downloads](https://tomcat.apache.org/download-10.cgi) |
| MySQL Server | 8.0+ | [MySQL Downloads](https://dev.mysql.com/downloads/) |
| IntelliJ IDEA | Any | [JetBrains](https://www.jetbrains.com/idea/) *(recommended)* |

---

### 1. Database Setup

Open your MySQL client and run the SQL script provided:

```bash
mysql -u root -p < src/main/db/schema.sql
```

Or manually execute the contents of `src/main/db/schema.sql`:

```sql
CREATE DATABASE CMS;
USE CMS;

CREATE TABLE user (
    id        VARCHAR(10)  PRIMARY KEY,
    name      VARCHAR(100),
    email     VARCHAR(100),
    user_name VARCHAR(50),
    password  VARCHAR(100),
    role      VARCHAR(20)
);

CREATE TABLE complaint (
    id          VARCHAR(10)  PRIMARY KEY,
    employee_id VARCHAR(10),
    title       VARCHAR(200),
    description TEXT,
    date        DATE,
    time        TIME,
    status      VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES user(id)
);
```

> **Note:** The seed data in `schema.sql` contains plain-text passwords for demo purposes. When using the real app, passwords are stored as **BCrypt hashes** after registration.

---

### 2. Configure the DataSource

The database connection is configured in `ContextListener.java`. Update the credentials to match your local MySQL setup:

```java
// src/main/java/listner/ContextListener.java
dataSource.setUrl("jdbc:mysql://localhost:3306/CMS");
dataSource.setUsername("root");       // ← your MySQL username
dataSource.setPassword("yourpassword"); // ← your MySQL password
dataSource.setInitialSize(5);
dataSource.setMaxTotal(50);
```

---

### 3. Build & Deploy

#### Option A: IntelliJ IDEA (Recommended)

1. Open the project in IntelliJ IDEA.
2. Go to **Run → Edit Configurations** and add a **Tomcat Server** (Local).
3. Under the **Deployment** tab, add the artifact `CMS:war exploded`.
4. Set the **Application context** to `/CMS` (or `/`).
5. Click **Run** ▶ — IntelliJ will build and deploy to Tomcat automatically.

#### Option B: Maven CLI + Manual Tomcat Deploy

```bash
# 1. Clone the repository
git clone https://github.com/ManuthLakdiw/CMS-AAD-ASSIGNMENT.git
cd CMS-AAD-ASSIGNMENT

# 2. Build the WAR file
mvn clean package

# 3. Copy the WAR to Tomcat
cp target/CMS-1.0-SNAPSHOT.war /path/to/tomcat/webapps/CMS.war

# 4. Start Tomcat
/path/to/tomcat/bin/startup.sh   # macOS / Linux
/path/to/tomcat/bin/startup.bat  # Windows
```

#### 4. Access the Application

```
http://localhost:8080/CMS/
```

---

## 🔑 Default User Credentials

> ⚠️ **Important:** The seed data in `schema.sql` uses plain-text passwords for demonstration. Real accounts registered through the Sign Up page use BCrypt-hashed passwords. Use the Sign Up page or update the DB directly to create valid BCrypt accounts.

| Role | Username | Password | Name |
|---|---|---|---|
| Admin | `johndoe` | `password123` | John Doe |
| Admin | `sarahw` | `password321` | Sarah Wilson |
| Employee | `janesmith` | `password456` | Jane Smith |
| Employee | `mikejohn` | `password789` | Mike Johnson |
| Employee | `tombrown` | `password654` | Tom Brown |

---

## 🖥 Application Pages

| Page | URL | Access |
|---|---|---|
| Landing Page | `/` | Public |
| Sign In | `/view/signin.jsp` | Public |
| Sign Up | `/view/signup.jsp` | Public |
| Employee Dashboard | `/complaint` | Employee (session required) |
| Admin Dashboard | `/complaint` | Admin (session required) |
| All Employees View | `/employees` | Admin (session required) |
| Logout | `/logout` | Any authenticated user |

---

## 📦 Dependencies

All dependencies are managed via **Apache Maven** (`pom.xml`):

```xml
<!-- Jakarta Servlet API -->
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.1.0-M2</version>
    <scope>provided</scope>
</dependency>

<!-- Jakarta Annotation API -->
<dependency>
    <groupId>jakarta.annotation</groupId>
    <artifactId>jakarta.annotation-api</artifactId>
    <version>3.0.0</version>
</dependency>

<!-- Lombok (code generation) -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.36</version>
</dependency>

<!-- BCrypt Password Hashing -->
<dependency>
    <groupId>org.mindrot</groupId>
    <artifactId>jbcrypt</artifactId>
    <version>0.4</version>
</dependency>

<!-- MySQL JDBC Connector -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>9.2.0</version>
</dependency>

<!-- Apache Commons DBCP2 (Connection Pooling) -->
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-dbcp2</artifactId>
    <version>2.13.0</version>
</dependency>
```

---

## 🔒 Security Considerations

- **BCrypt Hashing**: All passwords are hashed using BCrypt before being stored in the database. Plain-text passwords are never persisted.
- **Session Validation**: Every protected servlet checks for an active `HttpSession` with a valid `UserBean`. Unauthorized requests are immediately redirected to the sign-in page.
- **Role Enforcement**: `ComplaintServlet` reads the `role` attribute from the session and serves either the admin or employee view accordingly.
- **Prepared Statements**: All SQL queries in `CrudUtil`, `UserDao`, and `ComplaintDao` use `PreparedStatement`, preventing SQL injection.
- **Connection Pooling**: The `ContextListener` initializes an Apache DBCP2 connection pool at application startup, ensuring efficient and safe database connection management.

---

## 👨‍💻 Author

**Manuth Lakdiw**

- 📧 Email: [manuthlakdiv2006.com](mailto:manuthlakdiv2006@gmail.com)
- 🐙 GitHub: [@ManuthLakdiw](https://github.com/ManuthLakdiw)
- 🎓 Institute: IJSE — Institute of Software Engineering
- 📚 Module: Advanced Application Development (AAD)

---

## 📄 License

This project is developed for academic purposes as part of the **AAD module** at IJSE. All rights reserved © 2025 Manuth Lakdiw.

---

<div align="center">
  <sub>Built with ❤️ using Jakarta EE, MySQL & Apache Tomcat</sub>
</div>
