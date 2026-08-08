import 'expense_model.dart';

/// Represents one record stored in Hive.
///
/// ExpenseModel contains the business data.
/// key identifies the record inside Hive.
class ExpenseRecord {
  final int key;
  final ExpenseModel expense;

  const ExpenseRecord({
    required this.key,
    required this.expense,
  });

  ExpenseRecord copyWith({
    int? key,
    ExpenseModel? expense,
  }) {
    return ExpenseRecord(
      key: key ?? this.key,
      expense: expense ?? this.expense,
    );
  }
}