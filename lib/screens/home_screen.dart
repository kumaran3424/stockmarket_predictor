import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/price_service.dart';
import '../widgets/stock_chart.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // For demo use fake streaming
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PriceService>(context, listen: false).startFakeStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prices = Provider.of<PriceService>(context).prices;
    final price = prices['AAPL'] ?? 170.0;
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AAPL', style: Theme.of(context).textTheme.titleLarge),
                    Text('\$${price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.displayMedium),
                  ],
                ),
                const Spacer(),
                SizedBox(width: 100, height: 100, child: Lottie.asset('assets/animations/trade.json')),
              ],
            ),
          ),  
          const Expanded(child: StockChart(symbol: 'AAPL')),
        ],
      ),
    );
  }
}
