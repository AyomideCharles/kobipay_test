import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobipayy/core/constants.dart';
import 'package:kobipayy/core/utils.dart';
import 'package:kobipayy/widgets/data_chart.dart';
import 'package:kobipayy/widgets/fade_in_animation.dart';
import 'package:kobipayy/widgets/month_dropdown.dart';
import 'package:kobipayy/widgets/transaction_card.dart';
import 'package:kobipayy/views/transaction_details.dart';
import '../providers/transaction_providers.dart';

class TransactionListScreen extends ConsumerWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txState = ref.watch(transactionsListProvider);
    final filteredList = ref.watch(filteredTransactionsProvider);
    final selectedMonth = ref.watch(monthFilterProvider);

    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions History'),
        centerTitle: true,
      ),
      body: txState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          final total = filteredList.fold<double>(0, (p, e) => p + e.amount);

          return RefreshIndicator(
            onRefresh: () => ref.read(transactionsListProvider.notifier).load(),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/netflix.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text('Netflix',
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary)),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text('Production Company',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16.sp,
                            )),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total payment'),
                              currencyText(
                                total,
                                list.isNotEmpty ? list.first.currency : 'USD',
                              ),
                            ],
                          ),
                          MonthDropdown(
                              selectedMonth: selectedMonth,
                              months: const ["All", ...monthNames],
                              onChanged: (value) {
                                if (value != null) {
                                  ref.read(monthFilterProvider.notifier).state =
                                      value;
                                }
                              }),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      SizedBox(
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ExpenseChart(
                              transactions: list,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  formatCurrency(total,
                                      currency: list.isNotEmpty
                                          ? list.first.currency
                                          : 'USD'),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  'Netflix Expenses',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Transaction',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                if (filteredList.isEmpty)
                  const Center(
                      child: Text('No transaction available for this month!!')),
                ...filteredList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tx = entry.value;

                  return StaggeredFadeIn(
                    index: index,
                    duration: const Duration(milliseconds: 550),
                    delayBetween: const Duration(milliseconds: 400),
                    child: TransactionCard(
                      tx: tx,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                TransactionDetailScreen(transaction: tx),
                          ),
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
