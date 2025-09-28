import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String symbol;
  final double price;
  final double change;
  final double changePercent;
  final int volume;
  final DateTime lastUpdate;

  const Stock({
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.volume,
    required this.lastUpdate,
  });

  Stock copyWith({
    String? symbol,
    double? price,
    double? change,
    double? changePercent,
    int? volume,
    DateTime? lastUpdate,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      volume: volume ?? this.volume,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      volume: json['volume'] as int,
      lastUpdate: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [symbol, price, change, changePercent, volume];
}
