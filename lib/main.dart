import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobipayy/core/constants.dart';
import 'package:kobipayy/views/transaction_history.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.background,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  centerTitle: true),
              scaffoldBackgroundColor: AppColors.background,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textTheme:
                  GoogleFonts.fahkwangTextTheme(Theme.of(context).textTheme)),
          home: const TransactionListScreen(),
        );
      },
    );
  }
}
