# **Task Manager App – Flutter + Back4App (BaaS)**

A simple cross-platform task management application built using **Flutter** for the frontend and **Back4App (Parse Server)** as the cloud backend.
The app supports **user authentication** (Sign Up / Login) and full **CRUD operations** for tasks.

---

## ⭐ **Project Overview**

This project demonstrates how Flutter can be combined with a Backend-as-a-Service (BaaS) like **Back4App Parse Server** to build a fully functional cloud-powered application *without writing custom backend code*.

### Key Features

* ✔ **User Sign Up & Login** using Back4App authentication
* ✔ **Session Token handling** for secure API access
* ✔ **Create, Read, Update, Delete (CRUD)** for tasks
* ✔ **REST API calls** (no Parse SDK used)
* ✔ **Modern UI** with dark theme
* ✔ Works on **Android, iOS, Web**

---

## 📱 **Screens Included**

* **Login Page**
* **Signup Page**
* **Home Page** (Task listing, delete, pull-to-refresh)
* **Add Task Page**
* **Edit Task Page**

---

## 🧩 **Tech Stack Used**

### **Frontend**

| Technology    | Purpose              |
| ------------- | -------------------- |
| Flutter       | Cross-platform UI    |
| Dart          | Programming language |
| FutureBuilder | Async UI rendering   |
| Navigator     | App routing          |
| Widgets       | UI building          |

### **Backend**

| Technology     | Purpose                       |
| -------------- | ----------------------------- |
| REST API       | Communicating with Back4App   |
| JSON           | Handling requests & responses |
| Session Tokens | Secure actions (CRUD)         |

### **Back4App (Parse Server)**

| Feature         | Use                   |
| --------------- | --------------------- |
| Parse Dashboard | Managing data & users |
| Classes         | `User`, `Task`        |
| App Keys        | REST communication    |
| Cloud Storage   | Auto data management  |

---

## 📂 **Project Structure**

```
lib/
 ├── main.dart
 ├── services/
 │     └── api_service.dart
 ├── pages/
 │     ├── login_page.dart
 │     ├── signup_page.dart
 │     ├── home_page.dart
 │     ├── add_task_page.dart
 │     └── edit_task_page.dart
 └── models/ (optional)
```

---

## 🚀 **How It Works (Flow)**

### **1. User Authentication**

* Signup → user stored in Back4App `_User` class
* Login → returns `sessionToken`
* App passes `sessionToken` to all task screens

### **2. Task Management**

* Create → `/classes/Task` POST
* Read → `/classes/Task` GET
* Update → `/classes/Task/{id}` PUT
* Delete → `/classes/Task/{id}` DELETE

All requests include:

```
X-Parse-Application-Id
X-Parse-REST-API-Key
X-Parse-Session-Token
```

---

## 📘 **Learnings (As a Student)**

### **Flutter Learnings**

* Understanding **widgets**, stateful & stateless components
* Using **Navigator** for multi-screen apps
* Using **FutureBuilder** to display async API results
* Handling input, buttons, themes, and layouts

### **Dart Learnings**

* Understanding async functions (`async` / `await`)
* JSON encoding/decoding
* Using packages like `http`

### **Backend & API Learnings**

* How **REST APIs** work
* Understanding HTTP methods: GET, POST, PUT, DELETE
* Passing headers & JSON bodies
* Handling **status codes** (200, 201, 400, 401, etc.)

### **Back4App Learnings**

* Creating Parse **Classes** (like SQL tables)
* Managing dashboard & live data
* Using REST API keys securely
* How session tokens authorize users
* Auto-handling of database storage without writing backend code

---

## 🛠 **Installation & Setup**

### Step 1: Clone this Repo

```
git clone https://github.com/<your-username>/task-manager-back4app.git
cd task-manager-back4app
```

### Step 2: Add Your Back4App Credentials

Create:

```
lib/services/parse_service.dart
```

Inside:

```dart
class ParseConfig {
  static const String appId = "YOUR_APP_ID";
  static const String restKey = "YOUR_REST_KEY";
  static const String baseUrl = "https://parseapi.back4app.com";
}
```

### Step 3: Run the App

```
flutter pub get
flutter run
```

---

## 🎯 **Future Improvements**

* Add task status (completed/incomplete)
* Add due date, categories
* Add notifications
* Add user profile page
* Deploy as PWA for web

---

## 🧑‍🎓 **Submitted By**

**Saleel P M**

2022HT15002

BITS Pilani - WILP Program

