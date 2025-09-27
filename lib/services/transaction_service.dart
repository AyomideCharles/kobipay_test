import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kobipayy/core/constants.dart';
import 'package:kobipayy/model/transaction_model.dart';

class TransactionService {
  const TransactionService();

  Future<List<TransactionModel>> fetchTransactionsFromAssets() async {
    await Future.delayed(const Duration(milliseconds: 1800));
    final response = await rootBundle.loadString(AppConfig.mockTransaction);
    final List<dynamic> jsonList = json.decode(response);
    return jsonList
        .map((j) => TransactionModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }
}
