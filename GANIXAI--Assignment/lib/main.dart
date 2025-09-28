import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/stock_service.dart';
import 'screens/trading_screen.dart';

void main() {
  runApp(const TradingApp());
}

class TradingApp extends StatelessWidget {
  const TradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StockService(),
      child: MaterialApp(
        title: 'Real-Time Trading',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        home: const TradingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
