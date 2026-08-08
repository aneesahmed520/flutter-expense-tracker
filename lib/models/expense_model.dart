import 'package:hive/hive.dart';

class ExpenseModel {
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final bool isIncome;

  const ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.isIncome,
  });

  ExpenseModel copyWith({
    String? title,
    double? amount,
    String? category,
    DateTime? date,
    bool? isIncome,
  }) {
    return ExpenseModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}

class ExpenseAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseModel read(BinaryReader reader) {
    return ExpenseModel(
      title: reader.readString(),
      amount: reader.readDouble(),
      category: reader.readString(),
      date: DateTime.parse(reader.readString()),
      isIncome: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeString(obj.category);
    writer.writeString(obj.date.toIso8601String());
    writer.writeBool(obj.isIncome);
  }
}