import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_model.dart';

class HiveService {
  static const String expenseBoxName = 'expenses';

  /// Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExpenseAdapter());
    }

    await Hive.openBox<ExpenseModel>(expenseBoxName);
  }

  /// Expense Box
  static Box<ExpenseModel> get expenseBox =>
      Hive.box<ExpenseModel>(expenseBoxName);
}