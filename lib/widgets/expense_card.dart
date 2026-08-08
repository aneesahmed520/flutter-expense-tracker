import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense_record.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseRecord record;
  final VoidCallback? onTap;

  const ExpenseCard({
    super.key,
    required this.record,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final expense = record.expense;

    final bool isIncome = expense.isIncome;

    final Color amountColor =
    isIncome ? Colors.green : Colors.red;

    final IconData icon =
    isIncome ? Icons.arrow_downward : Icons.arrow_upward;

    final String formattedDate =
    DateFormat('dd MMM yyyy').format(expense.date);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              //--------------------------------------------------
              // Icon
              //--------------------------------------------------

              CircleAvatar(
                radius: 24,
                backgroundColor:
                amountColor.withValues(alpha: 0.15),
                child: Icon(
                  icon,
                  color: amountColor,
                ),
              ),

              const SizedBox(width: 16),

              //--------------------------------------------------
              // Transaction Details
              //--------------------------------------------------

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      expense.category,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              //--------------------------------------------------
              // Amount
              //--------------------------------------------------

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Text(
                    isIncome ? "+ Rs" : "- Rs",
                    style: TextStyle(
                      color: amountColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    expense.amount.toStringAsFixed(2),
                    style: TextStyle(
                      color: amountColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}