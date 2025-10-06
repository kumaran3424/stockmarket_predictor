import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PriceService extends ChangeNotifier {
  final Map<String, double> _prices = {};
  WebSocketChannel? _channel;
  Timer? _fakeTimer;

  Map<String, double> get prices => _prices;

  // For demo: start fake streaming prices
  void startFakeStream() {
    stop();
    _fakeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _prices.update('AAPL', (v) => v + (0.5 - (DateTime.now().millisecond % 100)/100), ifAbsent: () => 170.0 + (DateTime.now().second % 10));
      notifyListeners();
    });
  }

  // Real streaming (e.g., Finnhub)
  void startRealStream(String symbol, String apiKey) {
    stop();
    final url = Uri.parse('wss://ws.finnhub.io?token=$apiKey');
    _channel = WebSocketChannel.connect(url);
    _channel!.sink.add(jsonEncode({'type': 'subscribe', 'symbol': symbol}));
    _channel!.stream.listen((msg) {
      final data = jsonDecode(msg);
      if (data['data'] != null) {
        for (var item in data['data']) {
          _prices[item['s']] = item['p'] + 0.0;
        }
        notifyListeners();
      }
    }, onError: (e) {
      // handle error
    });
  }

  void stop() {
    _fakeTimer?.cancel();
    _channel?.sink.close();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
