import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_record.dart';
import '../providers/expense_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/expense_card.dart';
import '../widgets/summary_card.dart';
import 'add_edit_expense_screen.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

void _showOptions(
BuildContext context,
ExpenseRecord record,
) {
showModalBottomSheet(
context: context,
builder: (_) {
return SafeArea(
child: Wrap(
children: [
ListTile(
leading: const Icon(Icons.edit),
title: const Text("Edit Transaction"),
onTap: () {
Navigator.pop(context);

Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
AddEditExpenseScreen(
record: record,
),
),
);
},
),

ListTile(
leading: const Icon(
Icons.delete,
color: Colors.red,
),
title: const Text(
"Delete Transaction",
style: TextStyle(
color: Colors.red,
),
),
onTap: () {
Navigator.pop(context);
_deleteExpense(
context,
record,
);
},
),
],
),
);
},
);
}

void _deleteExpense(
BuildContext context,
ExpenseRecord record,
) {
showDialog(
context: context,
builder: (_) {
return AlertDialog(
title: const Text(
"Delete Transaction",
),
content: const Text(
"Are you sure you want to delete this transaction?",
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: const Text(
"Cancel",
),
),
ElevatedButton(
onPressed: () async {
await context
.read<ExpenseProvider>()
.deleteExpense(record);

if (context.mounted) {
Navigator.pop(context);

ScaffoldMessenger.of(context)
.showSnackBar(
const SnackBar(
content: Text(
"Transaction deleted successfully.",
),
),
);
}
},
child: const Text(
"Delete",
),
),
],
);
},
);
}

@override
Widget build(BuildContext context) {
final provider =
context.watch<ExpenseProvider>();

return Scaffold(
appBar: AppBar(
title: const Text(
"Expense Tracker",
),
centerTitle: true,
),

floatingActionButton:
FloatingActionButton(
child: const Icon(Icons.add),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
const AddEditExpenseScreen(),
),
);
},
),

body: Padding(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
const Text(
"Hello 👋",
style: TextStyle(
fontSize: 18,
),
),

const SizedBox(height: 5),

const Text(
"Welcome Back",
style: TextStyle(
fontSize: 28,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 20),



//==================================================
// Search
//==================================================

TextField(
decoration: InputDecoration(
hintText: "Search transactions...",
prefixIcon: const Icon(Icons.search),
suffixIcon: provider.searchQuery.isNotEmpty
? IconButton(
icon: const Icon(Icons.clear),
onPressed: provider.clearSearch,
)
: null,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
),
),
onChanged: provider.updateSearch,
),

const SizedBox(height: 20),

//==================================================
// Balance Card
//==================================================

Card(
color: AppTheme.primaryColor,
elevation: 4,
shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(16),
),
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
const Text(
"Current Balance",
style: TextStyle(
color: Colors.white70,
fontSize: 18,
),
),

const SizedBox(height: 10),

Text(
"Rs ${provider.balance.toStringAsFixed(2)}",
style: const TextStyle(
color: Colors.white,
fontSize: 32,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
"${provider.transactionCount} Transactions",
style: const TextStyle(
color: Colors.white70,
),
),
],
),
),
),

const SizedBox(height: 20),

//==================================================
// Income / Expense Cards
//==================================================

Row(
children: [
Expanded(
child: SummaryCard(
title: "Income",
amount:
"Rs ${provider.totalIncome.toStringAsFixed(2)}",
icon: Icons.arrow_downward,
iconColor: Colors.green,
backgroundColor:
Colors.green.shade100,
),
),

const SizedBox(width: 10),

Expanded(
child: SummaryCard(
title: "Expense",
amount:
"Rs ${provider.totalExpense.toStringAsFixed(2)}",
icon: Icons.arrow_upward,
iconColor: Colors.red,
backgroundColor:
Colors.red.shade100,
),
),
],
),

const SizedBox(height: 30),

const Text(
"Recent Transactions",
style: TextStyle(
fontSize: 22,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 15),

Expanded(
child: provider.filteredRecords.isEmpty
? Center(
child: Text(
provider.searchQuery.isEmpty
? "No transactions yet"
: "No matching transactions",
style: const TextStyle(
fontSize: 18,
),
),
)


    : ListView.builder(
  itemCount: provider.filteredRecords.length,
  itemBuilder: (context, index) {
    final ExpenseRecord record =
    provider.filteredRecords[index];

    return ExpenseCard(
      record: record,
      onTap: () {
        _showOptions(
          context,
          record,
        );
      },
    );
  },
),
),
],
),
),
);
}
}


