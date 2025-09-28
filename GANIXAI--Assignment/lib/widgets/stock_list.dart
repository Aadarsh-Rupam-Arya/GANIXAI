import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/stock_service.dart';
import 'stock_item.dart';

class StockList extends StatelessWidget {
  const StockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StockService>(
      builder: (context, stockService, child) {
        final stocks = stockService.stocks;
        final stockList = stocks.values.toList();

        return ListView.builder(
          // Key optimizations:
          // 1. itemExtent for consistent item height - improves scroll performance
          itemExtent: 80.0,
          // 2. addAutomaticKeepAlives: false - reduces memory usage
          addAutomaticKeepAlives: false,
          // 3. addRepaintBoundaries: false - reduces layer complexity for simple items
          addRepaintBoundaries: false,
          itemCount: stockList.length,
          itemBuilder: (context, index) {
            final stock = stockList[index];
            // 4. Use ValueKey for widget identity - prevents unnecessary rebuilds
            return StockItem(key: ValueKey(stock.symbol), stock: stock);
          },
        );
      },
    );
  }
}
