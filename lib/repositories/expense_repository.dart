import 'package:hive/hive.dart';

import '../models/expense_model.dart';
import '../models/expense_record.dart';
import '../services/hive_service.dart';

class ExpenseRepository {
  final Box<ExpenseModel> _box = HiveService.expenseBox;

  /// Returns all expenses sorted by newest first.
  List<ExpenseRecord> getAllExpenses() {
    final List<ExpenseRecord> records = [];

    for (final key in _box.keys) {
      if (key is! int) continue;

      final expense = _box.get(key);

      if (expense != null) {
        records.add(
          ExpenseRecord(
            key: key,
            expense: expense,
          ),
        );
      }
    }

    records.sort(
          (a, b) => b.expense.date.compareTo(a.expense.date),
    );

    return records;
  }

  /// Add new expense
  Future<void> addExpense(
      ExpenseModel expense,
      ) async {
    await _box.add(expense);
  }

  /// Update existing expense
  Future<void> updateExpense({
    required int key,
    required ExpenseModel expense,
  }) async {
    await _box.put(
      key,
      expense,
    );
  }

  /// Delete expense
  Future<void> deleteExpense(
      ExpenseRecord record,
      ) async {
    await _box.delete(record.key);
  }

  /// Delete all expenses
  Future<void> clearAll() async {
    await _box.clear();
  }

  /// Get one record by key
  ExpenseRecord? getByKey(int key) {
    final expense = _box.get(key);

    if (expense == null) {
      return null;
    }

    return ExpenseRecord(
      key: key,
      expense: expense,
    );
  }

  int get count => _box.length;

  bool get isEmpty => _box.isEmpty;

  bool get isNotEmpty => _box.isNotEmpty;
}