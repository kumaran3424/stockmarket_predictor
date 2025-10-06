import 'dart:math';

class Stock {
  final String symbol;
  final String name;
  final double currentPrice;
  final double change;
  final double changePercent;
  final double prediction;
  final double confidence;
  final List<PricePoint> priceHistory;

  Stock({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
    required this.prediction,
    required this.confidence,
    this.priceHistory = const [],
  });
}

class PricePoint {
  final DateTime time;
  final double price;

  PricePoint({required this.time, required this.price});
}

class PredictionAlgorithm {
  static double predictNextPrice(List<PricePoint> history, double currentPrice) {
    if (history.isEmpty) {
      // If no history, return current price with small random variation
      return currentPrice * (1 + _randomVariation());
    }
    
    if (history.length < 5) {
      // Simple average for small datasets
      final avg = history.map((p) => p.price).reduce((a, b) => a + b) / history.length;
      return (currentPrice + avg) / 2 * (1 + _randomVariation() * 0.5);
    }
    
    // Use weighted moving average giving more importance to recent prices
    final recentPrices = history.sublist(history.length - 5);
    double weightedSum = 0;
    double weightSum = 0;
    
    for (int i = 0; i < recentPrices.length; i++) {
      final weight = (i + 1).toDouble(); // Linear weights: 1, 2, 3, 4, 5
      weightedSum += recentPrices[i].price * weight;
      weightSum += weight;
    }
    
    final wma = weightedSum / weightSum;
    final trend = (currentPrice - wma) / wma;
    
    // Combine WMA with current price and add some noise
    final prediction = currentPrice * (1 + trend * 0.6 + _randomVariation() * 0.3);
    
    return prediction;
  }

  static double calculateConfidence(List<PricePoint> history) {
    if (history.length < 3) return 0.5 + _randomVariation().abs() * 0.3;
    
    // Calculate volatility-based confidence
    final priceChanges = <double>[];
    for (int i = 1; i < history.length; i++) {
      final change = (history[i].price - history[i-1].price) / history[i-1].price;
      priceChanges.add(change.abs());
    }
    
    final avgVolatility = priceChanges.reduce((a, b) => a + b) / priceChanges.length;
    final confidence = (1 - avgVolatility * 15).clamp(0.5, 0.95);
    
    return confidence.toDouble();
  }

  static double _randomVariation() {
    return (Random().nextDouble() - 0.5) * 0.04; // ±2% random variation
  }

  static List<PricePoint> generatePriceHistory(double currentPrice, int points) {
    final now = DateTime.now();
    final history = <PricePoint>[];
    double price = currentPrice * (1 - Random().nextDouble() * 0.1); // Start 0-10% lower
    
    for (int i = points - 1; i >= 0; i--) {
      final time = now.subtract(Duration(hours: i));
      // Random walk with slight upward bias
      price = price * (1 + (Random().nextDouble() - 0.45) * 0.02);
      history.add(PricePoint(time: time, price: price));
    }
    
    return history;
  }
}