# 💰 Flutter Expense Tracker

A professional cross-platform **Expense Tracker application** built with Flutter and Dart. The application allows users to manage income and expenses, search transactions, monitor their balance, and persist financial records locally using Hive.

The project follows a clean and maintainable architecture using **Provider for state management** and a **Repository pattern** for data access.

---

## 📱 Features

* ➕ Add income and expense transactions
* ✏️ Edit existing transactions
* 🗑️ Delete transactions
* 🔍 Search transactions
* 💰 Automatic balance calculation
* 📊 Income and expense summaries
* 🗂️ Transaction categories
* 📅 Transaction date selection
* 💾 Local data persistence with Hive
* ⚡ Reactive state management with Provider
* 🎨 Material Design user interface
* 📱 Android support
* 🖥️ Windows support

---

## 🛠️ Tech Stack

| Technology      | Purpose               |
| --------------- | --------------------- |
| Flutter 3.44.6  | Application framework |
| Dart 3.12+      | Programming language  |
| Provider        | State management      |
| Hive            | Local database        |
| Intl            | Date formatting       |
| Material Design | User interface        |

---

## 🏗️ Architecture

The application uses a layered architecture to keep the UI, business logic, and data access separate.

```text
┌──────────────────────────┐
│        UI Layer          │
│                          │
│ HomeScreen               │
│ AddEditExpenseScreen     │
│ ExpenseCard              │
│ SummaryCard              │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│     State Management     │
│                          │
│ ExpenseProvider          │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│      Repository Layer    │
│                          │
│ ExpenseRepository        │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│       Data Layer         │
│                          │
│ HiveService              │
│ Hive Database            │
└──────────────────────────┘
```

### Data Model

The application separates the Hive record key from the expense data:

```text
ExpenseRecord
├── key
└── expense
    ├── title
    ├── amount
    ├── category
    ├── date
    └── isIncome
```

This keeps the domain model independent from Hive's internal key management.

---

## 📂 Project Structure

```text
lib/
│
├── models/
│   ├── expense_model.dart
│   └── expense_record.dart
│
├── providers/
│   └── expense_provider.dart
│
├── repositories/
│   └── expense_repository.dart
│
├── screens/
│   ├── add_edit_expense_screen.dart
│   ├── home_screen.dart
│   └── splash_screen.dart
│
├── services/
│   └── hive_service.dart
│
├── theme/
│   └── app_theme.dart
│
├── widgets/
│   ├── expense_card.dart
│   └── summary_card.dart
│
└── main.dart
```

---

## 🔄 CRUD Operations

The application supports complete transaction management.

### Create

Users can add:

* Title
* Amount
* Category
* Date
* Transaction type

### Read

Transactions are loaded from the local Hive database.

### Update

Existing transactions can be edited using their Hive key.

### Delete

Transactions can be safely removed using their associated Hive key.

---

## 🔎 Search

The application provides real-time transaction searching.

Users can search by:

* Transaction title
* Category

Search is handled through `ExpenseProvider` without directly coupling the UI to Hive.

---

## 💾 Local Data Persistence

Hive is used as the local database.

The application initializes Hive before the Flutter application starts:

```dart
await HiveService.init();
```

Transactions remain available after restarting the application.

---

## 🚀 Getting Started

### Prerequisites

Make sure you have installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android SDK for Android development

Check your Flutter installation:

```bash
flutter doctor
```

---

### Clone the Repository

```bash
git clone https://github.com/aneesahmed520/flutter-expense-tracker.git
```

Move into the project:

```bash
cd flutter-expense-tracker
```

Install dependencies:

```bash
flutter pub get
```

---

### Run the Application

Check connected devices:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

---

## 🧪 Analyze the Project

Run:

```bash
flutter analyze
```

The project should contain no compilation errors.

---

## 📸 Screenshots

Screenshots will be added here to demonstrate the main application screens.

### Home Screen

> Screenshot coming soon.

### Add Transaction

> Screenshot coming soon.

### Edit Transaction

> Screenshot coming soon.

### Search

> Screenshot coming soon.

---

## 🔮 Future Improvements

Planned improvements include:

* 📊 Expense charts and analytics
* 📅 Monthly and yearly reports
* 📄 CSV/PDF export
* 🌙 Dark mode
* 🔔 Budget notifications
* 🎯 Monthly spending limits
* 🏷️ Custom categories
* 🔐 Optional application security
* ☁️ Cloud backup and synchronization
* 📈 Advanced financial statistics

---

## 🎯 Learning Objectives

This project demonstrates practical experience with:

* Flutter application development
* Dart programming
* State management
* Local database integration
* Repository pattern
* CRUD operations
* Form validation
* Search functionality
* Responsive UI design
* Application architecture
* Git and GitHub workflow

---

## 👨‍💻 Author

**Anees Ahmed**

Computer Science Student | Flutter Developer

GitHub: `https://github.com/aneesahmed520`

---

## 📄 License

This project is available for educational and portfolio purposes.
