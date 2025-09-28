import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/stock.dart';

class StockService extends ChangeNotifier {
  final Map<String, Stock> _stocks = {};
  Timer? _timer;
  bool _isConnected = false;

  // Generate 50 stock symbols
  static const List<String> _symbols = [
    'AAPL',
    'GOOGL',
    'MSFT',
    'AMZN',
    'TSLA',
    'META',
    'NVDA',
    'NFLX',
    'UBER',
    'SPOT',
    'AMD',
    'INTC',
    'CRM',
    'ORCL',
    'ADBE',
    'PYPL',
    'SQ',
    'SHOP',
    'ZOOM',
    'DOCU',
    'TWTR',
    'SNAP',
    'PINS',
    'ROKU',
    'ZM',
    'CRWD',
    'SNOW',
    'PLTR',
    'COIN',
    'RBLX',
    'U',
    'NET',
    'FSLY',
    'MDB',
    'OKTA',
    'DDOG',
    'ESTC',
    'TEAM',
    'WORK',
    'NOW',
    'VEEV',
    'WDAY',
    'SPLK',
    'PANW',
    'ZS',
    'CHGG',
    'LMND',
    'ROOT',
    'OPEN',
    'WISH',
  ];

  Map<String, Stock> get stocks => Map.unmodifiable(_stocks);
  bool get isConnected => _isConnected;

  StockService() {
    _initializeStocks();
    _startSimulation();
  }

  void _initializeStocks() {
    final random = Random();
    for (String symbol in _symbols) {
      final basePrice = 50 + random.nextDouble() * 200; // $50-$250 range
      _stocks[symbol] = Stock(
        symbol: symbol,
        price: basePrice,
        change: 0.0,
        changePercent: 0.0,
        volume: random.nextInt(1000000) + 100000,
        lastUpdate: DateTime.now(),
      );
    }
  }

  void _startSimulation() {
    _isConnected = true;
    // Simulate WebSocket updates every 500ms
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _updateRandomStocks();
    });
  }

  void _updateRandomStocks() {
    final random = Random();
    // Update 5-15 random stocks each cycle for realistic behavior
    final updateCount = 5 + random.nextInt(10);
    final symbolsToUpdate = [..._symbols]..shuffle();

    for (int i = 0; i < updateCount; i++) {
      final symbol = symbolsToUpdate[i];
      final currentStock = _stocks[symbol]!;

      // Generate realistic price movement (-5% to +5%)
      final changePercent = (random.nextDouble() - 0.5) * 0.1; // -5% to +5%
      final newPrice = currentStock.price * (1 + changePercent);
      final change = newPrice - currentStock.price;

      _stocks[symbol] = currentStock.copyWith(
        price: newPrice,
        change: change,
        changePercent: changePercent * 100,
        volume: currentStock.volume + random.nextInt(10000),
        lastUpdate: DateTime.now(),
      );
    }

    // Only notify listeners once per update cycle
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _isConnected = false;
    super.dispose();
  }
}
