import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kobipayy/core/constants.dart';

String formatCurrency(double amount, {String currency = "USD"}) {
  final formatter = NumberFormat.simpleCurrency(name: currency);
  return formatter.format(amount);
}

Widget currencyText(double total, String currency) {
  final formatted = formatCurrency(total, currency: currency);
  final symbol = NumberFormat.simpleCurrency(name: currency).currencySymbol;

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: formatted.replaceAll(symbol, ""),
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 28.sp, 
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: " $symbol",
          style: TextStyle(
            fontFamily: 'fahkwang',
            color: AppColors.secondary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
