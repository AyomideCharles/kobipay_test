import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kobipayy/model/transaction_model.dart';

class TransactionService {
const TransactionService();


Future<List<TransactionModel>> fetchTransactionsFromAssets() async {
await Future.delayed(const Duration(milliseconds: 800));
final raw = await rootBundle.loadString('assets/transactions.json');
final List<dynamic> jsonList = json.decode(raw);
return jsonList.map((j) => TransactionModel.fromJson(j as Map<String, dynamic>)).toList();
}
}