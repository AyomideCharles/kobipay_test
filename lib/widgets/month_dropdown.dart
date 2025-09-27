import 'package:flutter/material.dart';
import 'package:kobipayy/core/constants.dart';

class MonthDropdown extends StatelessWidget {
  final String selectedMonth;
  final List<String> months;
  final ValueChanged<String?> onChanged;

  const MonthDropdown({
    super.key,
    required this.selectedMonth,
    required this.months,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedMonth,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
          dropdownColor: Colors.white,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          items: months.map((m) {
            return DropdownMenuItem(
              value: m,
              child: Text(m),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
