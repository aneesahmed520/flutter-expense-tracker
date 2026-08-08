import 'package:flutter/material.dart';

import '../models/expense_model.dart';
import '../models/expense_record.dart';
import '../repositories/expense_repository.dart';

class ExpenseProvider extends ChangeNotifier {
  final ExpenseRepository _repository = ExpenseRepository();

  List<ExpenseRecord> _records = [];
  String _searchQuery = '';

  ExpenseProvider() {
    refresh();
  }

  //==================================================
  // Getters
  //==================================================

  List<ExpenseRecord> get records => List.unmodifiable(_records);

  String get searchQuery => _searchQuery;

  bool get isEmpty => _records.isEmpty;

  bool get isNotEmpty => _records.isNotEmpty;

  int get transactionCount => _records.length;

  List<ExpenseRecord> get filteredRecords {
    if (_searchQuery.isEmpty) {
      return records;
    }

    return _records.where((record) {
      final expense = record.expense;

      return expense.title
          .toLowerCase()
          .contains(_searchQuery) ||
          expense.category
              .toLowerCase()
              .contains(_searchQuery);
    }).toList();
  }

  double get totalIncome {
    return _records
        .where((record) => record.expense.isIncome)
        .fold(
      0.0,
          (sum, record) => sum + record.expense.amount,
    );
  }

  double get totalExpense {
    return _records
        .where((record) => !record.expense.isIncome)
        .fold(
      0.0,
          (sum, record) => sum + record.expense.amount,
    );
  }

  double get balance => totalIncome - totalExpense;

  //==================================================
  // CRUD Operations
  //==================================================

  Future<void> refresh() async {
    _records = _repository.getAllExpenses();
    notifyListeners();
  }

  Future<void> addExpense(
      ExpenseModel expense,
      ) async {
    await _repository.addExpense(expense);
    await refresh();
  }

  Future<void> updateExpense({
    required int key,
    required ExpenseModel expense,
  }) async {
    await _repository.updateExpense(
      key: key,
      expense: expense,
    );

    await refresh();
  }

  Future<void> deleteExpense(
      ExpenseRecord record,
      ) async {
    await _repository.deleteExpense(record);
    await refresh();
  }

  Future<void> clearAll() async {
    await _repository.clearAll();
    await refresh();
  }

  //==================================================
  // Search
  //==================================================

  void updateSearch(String value) {
    _searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  //==================================================
  // Helpers
  //==================================================

  ExpenseRecord? getRecordByKey(int key) {
    try {
      return _records.firstWhere(
            (record) => record.key == key,
      );
    } catch (_) {
      return null;
    }
  }

  ExpenseRecord? getRecordAt(int index) {
    if (index < 0 || index >= _records.length) {
      return null;
    }

    return _records[index];
  }
}