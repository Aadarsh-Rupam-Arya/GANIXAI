import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/stock_service.dart';
import '../widgets/stock_list.dart';

class TradingScreen extends StatelessWidget {
  const TradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Trading'),
        actions: [
          Consumer<StockService>(
            builder: (context, stockService, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      stockService.isConnected
                          ? Icons.circle
                          : Icons.circle_outlined,
                      color: stockService.isConnected
                          ? Colors.green
                          : Colors.red,
                      size: 12,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      stockService.isConnected ? 'Live' : 'Disconnected',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: const StockList(),
    );
  }
}
