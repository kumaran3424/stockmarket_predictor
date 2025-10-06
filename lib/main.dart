import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/price_service.dart';
import 'screens/home_screen.dart';
import 'screens/news_screen.dart';
import 'screens/portfolio_screen.dart';
import 'screens/billionaires_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';
import 'models/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => PriceService()),
      ],
      child: MaterialApp(
        title: 'StockPulse',
        theme: AppTheme.lightTheme, // NO parentheses
darkTheme: AppTheme.darkTheme, // NO parentheses
debugShowCheckedModeBanner: false,

        home: const MainShell(),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  _MainShellState createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _pages = [
    const HomeScreen(),
    const PortfolioScreen(),
    const NewsScreen(),
    const BillionairesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Portfolio'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Billionaires'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
