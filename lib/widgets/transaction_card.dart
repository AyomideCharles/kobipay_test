import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobipayy/core/constants.dart';
import 'package:kobipayy/core/utils.dart';
import 'package:kobipayy/model/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel tx;
  final VoidCallback onTap;

  const TransactionCard({super.key, required this.tx, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        color: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(tx.merchantImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tx.merchant,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat.yMMMd().format(tx.date),
                      style: TextStyle(fontSize: 11.sp),
                    )
                    // Text(
                    //     '${tx.category} • ${DateFormat.yMMMd().format(tx.date)}',
                    //     style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatCurrency(tx.amount),
                    style: const TextStyle(color: AppColors.secondary),
                  ),
                  const SizedBox(height: 6),
                  // Text(tx.status,
                  //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //         color:
                  //             tx.status == 'Refunded' ? Colors.green : null)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
