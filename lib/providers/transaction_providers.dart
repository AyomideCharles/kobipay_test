import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobipayy/model/transaction_model.dart';
import '../services/transaction_service.dart';

final transactionServiceProvider =
    Provider<TransactionService>((ref) => const TransactionService());

final transactionsListProvider = StateNotifierProvider<TransactionsNotifier,
    AsyncValue<List<TransactionModel>>>((ref) {
  final svc = ref.read(transactionServiceProvider);
  return TransactionsNotifier(svc);
});

class TransactionsNotifier
    extends StateNotifier<AsyncValue<List<TransactionModel>>> {
  final TransactionService _service;
  TransactionsNotifier(this._service) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      state = const AsyncValue.loading();
      final data = await _service.fetchTransactionsFromAssets();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void refund(String id) {
    state.whenData((list) {
      final updated = list.map((t) {
        if (t.id == id) {
          return TransactionModel(
            id: t.id,
            merchant: t.merchant,
            merchantImage: t.merchantImage,
            amount: t.amount,
            currency: t.currency,
            date: t.date,
            method: t.method,
            status: 'Refunded',
            category: t.category,
            note: t.note,
          );
        }
        return t;
      }).toList();

      state = AsyncValue.data(updated);
    });
  }
}

final monthFilterProvider = StateProvider<String>((ref) => "All");

final filteredTransactionsProvider = Provider<List<TransactionModel>>((ref) {
  final txState = ref.watch(transactionsListProvider);
  final selectedMonth = ref.watch(monthFilterProvider);

  return txState.when(
    data: (list) {
      if (selectedMonth == "All") return list;

      return list.where((tx) {
        final monthName = _monthNames[tx.date.month - 1];
        return monthName == selectedMonth;
      }).toList();
    },
    error: (_, __) => [],
    loading: () => [],
  );
});

const _monthNames = [
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
