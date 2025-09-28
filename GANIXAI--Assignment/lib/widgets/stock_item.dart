import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/stock.dart';

class StockItem extends StatelessWidget {
  final Stock stock;

  const StockItem({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final priceFormatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );
    final changeFormatter = NumberFormat('+#,##0.00;-#,##0.00');
    final percentFormatter = NumberFormat('+#0.00%;-#0.00%');

    final isPositive = stock.change >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;

    return Container(
      // RepaintBoundary prevents this widget from being repainted
      // when other items in the list update
      child: RepaintBoundary(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          color: Colors.grey[900],
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Stock Symbol
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stock.symbol,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Vol: ${NumberFormat.compact().format(stock.volume)}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                // Current Price
                Expanded(
                  flex: 2,
                  child: Text(
                    priceFormatter.format(stock.price),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Change Amount and Percentage
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        changeFormatter.format(stock.change),
                        style: TextStyle(
                          color: changeColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        percentFormatter.format(stock.changePercent / 100),
                        style: TextStyle(color: changeColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                // Trend Indicator
                Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    color: changeColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
