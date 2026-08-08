import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_model.dart';
import '../models/expense_record.dart';
import '../providers/expense_provider.dart';

class AddEditExpenseScreen extends StatefulWidget {
  final ExpenseRecord? record;

  const AddEditExpenseScreen({
    super.key,
    this.record,
  });

  bool get isEditing => record != null;

  @override
  State<AddEditExpenseScreen> createState() =>
      _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState
    extends State<AddEditExpenseScreen> {
final GlobalKey<FormState> _formKey =
GlobalKey<FormState>();

late final TextEditingController _titleController;
late final TextEditingController _amountController;

late String _selectedCategory;
late bool _isIncome;
late DateTime _selectedDate;

bool _isSaving = false;

final List<String> _categories = [
'Food',
'Transport',
'Shopping',
'Bills',
'Health',
'Entertainment',
'Salary',
'Investment',
'Gift',
'Other',
];

@override
void initState() {
super.initState();

if (widget.isEditing) {
final expense = widget.record!.expense;

_titleController = TextEditingController(
text: expense.title,
);

_amountController = TextEditingController(
text: expense.amount.toString(),
);

_selectedCategory = expense.category;
_selectedDate = expense.date;
_isIncome = expense.isIncome;
} else {
_titleController = TextEditingController();

_amountController = TextEditingController();

_selectedCategory = 'Food';
_selectedDate = DateTime.now();
_isIncome = false;
}
}

@override
void dispose() {
_titleController.dispose();
_amountController.dispose();
super.dispose();
}

Future<void> _pickDate() async {
final DateTime? pickedDate =
await showDatePicker(
context: context,
initialDate: _selectedDate,
firstDate: DateTime(2024),
lastDate: DateTime(2100),
);

if (pickedDate != null) {
setState(() {
_selectedDate = pickedDate;
});
}
}

Future<void> _saveExpense() async {
if (!_formKey.currentState!.validate()) {
return;
}

setState(() {
_isSaving = true;
});

final expense = ExpenseModel(
title: _titleController.text.trim(),
amount: double.parse(
_amountController.text.trim(),
),
category: _selectedCategory,
date: _selectedDate,
isIncome: _isIncome,
);

final provider =
context.read<ExpenseProvider>();

try {
if (widget.isEditing) {
await provider.updateExpense(
key: widget.record!.key,
expense: expense,
);
} else {
await provider.addExpense(expense);
}

if (!mounted) return;

Navigator.pop(context);
} finally {
if (mounted) {
setState(() {
_isSaving = false;
});
}
}
}

@override
Widget build(BuildContext context) {
final String formattedDate =
"${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";

return Scaffold(
appBar: AppBar(
title: Text(
widget.isEditing
? "Edit Transaction"
: "Add Transaction",
),
centerTitle: true,
),
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Form(
key: _formKey,
child: Column(
children: [

//--------------------------------------------------
// Title
//--------------------------------------------------

TextFormField(
controller: _titleController,
textInputAction: TextInputAction.next,
decoration: const InputDecoration(
labelText: "Title",
hintText: "Enter transaction title",
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.title),
),
validator: (value) {
if (value == null ||
value.trim().isEmpty) {
return "Please enter a title";
}

if (value.trim().length < 2) {
return "Title is too short";
}

return null;
},
),

const SizedBox(height: 18),

//--------------------------------------------------
// Amount
//--------------------------------------------------

TextFormField(
controller: _amountController,
keyboardType:
const TextInputType.numberWithOptions(
decimal: true,
),
textInputAction: TextInputAction.next,
decoration: const InputDecoration(
labelText: "Amount",
hintText: "Enter amount",
border: OutlineInputBorder(),
prefixIcon:
Icon(Icons.currency_rupee),
),
validator: (value) {
if (value == null ||
value.trim().isEmpty) {
return "Please enter amount";
}

final amount =
double.tryParse(value);

if (amount == null) {
return "Invalid amount";
}

if (amount <= 0) {
return "Amount must be greater than zero";
}

return null;
},
),

const SizedBox(height: 18),

//--------------------------------------------------
// Category
//--------------------------------------------------

DropdownButtonFormField<String>(
value: _selectedCategory,
decoration: const InputDecoration(
labelText: "Category",
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.category),
),
items: _categories
.map(
(category) =>
DropdownMenuItem<String>(
value: category,
child: Text(category),
),
)
.toList(),
onChanged: (value) {
if (value == null) return;

setState(() {
_selectedCategory = value;
});
},
),

const SizedBox(height: 18),

//--------------------------------------------------
// Date
//--------------------------------------------------

Card(
elevation: 1,
child: ListTile(
leading: const Icon(
Icons.calendar_month,
),
title: const Text("Transaction Date"),
subtitle: Text(formattedDate),
trailing:
const Icon(Icons.arrow_forward_ios),
onTap: _pickDate,
),
),

const SizedBox(height: 20),

//--------------------------------------------------
// Income / Expense
//--------------------------------------------------

Card(
child: Column(
children: [

RadioListTile<bool>(
value: false,
groupValue: _isIncome,
title: const Text("Expense"),
secondary: const Icon(
Icons.arrow_upward,
color: Colors.red,
),
onChanged: (value) {
setState(() {
_isIncome = value!;
});
},
),

const Divider(height: 0),

RadioListTile<bool>(
value: true,
groupValue: _isIncome,
title: const Text("Income"),
secondary: const Icon(
Icons.arrow_downward,
color: Colors.green,
),
onChanged: (value) {
setState(() {
_isIncome = value!;
});
},
),
],
),
),

const SizedBox(height: 30),

  //--------------------------------------------------
  // Save / Update Button
  //--------------------------------------------------

  SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton.icon(
      onPressed: _isSaving ? null : _saveExpense,
      icon: _isSaving
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Icon(
        widget.isEditing
            ? Icons.save
            : Icons.add,
      ),
      label: Text(
        _isSaving
            ? "Please Wait..."
            : widget.isEditing
            ? "UPDATE TRANSACTION"
            : "SAVE TRANSACTION",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
      ),
    ),
  ),
],
),
),
),
),
);
}
}


