import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'My Portfolio',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade800,
                      Colors.blue.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPortfolioSummary(context),
                  const SizedBox(height: 24),
                  _buildHoldingsList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade800.withOpacity(0.8),
            Colors.purple.shade600.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Total Portfolio Value',
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$125,430.75',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Today\'s Gain', '+ \$2,345.67', Colors.green),
              _buildStatItem('Total Gain', '+ \$15,430.75', Colors.green),
              _buildStatItem('Cash', '\$12,567.89', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHoldingsList(BuildContext context) {
    final holdings = [
      {'symbol': 'AAPL', 'shares': 25, 'avgPrice': 150.32, 'currentPrice': 187.43},
      {'symbol': 'TSLA', 'shares': 15, 'avgPrice': 210.45, 'currentPrice': 245.18},
      {'symbol': 'MSFT', 'shares': 10, 'avgPrice': 320.67, 'currentPrice': 378.85},
      {'symbol': 'GOOGL', 'shares': 8, 'avgPrice': 125.89, 'currentPrice': 138.21},
      {'symbol': 'AMZN', 'shares': 5, 'avgPrice': 145.23, 'currentPrice': 156.78},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Holdings',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...holdings.map((holding) => _buildHoldingItem(context, holding)),
      ],
    );
  }

  Widget _buildHoldingItem(BuildContext context, Map<String, dynamic> holding) {
    final totalCost = holding['shares'] * holding['avgPrice'];
    final currentValue = holding['shares'] * holding['currentPrice'];
    final gain = currentValue - totalCost;
    final gainPercent = (gain / totalCost) * 100;
    final isPositive = gain >= 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                holding['symbol'].toString().substring(0, 2),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holding['symbol'],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${holding['shares']} shares',
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${currentValue.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${isPositive ? '+' : ''}\$${gain.toStringAsFixed(2)} (${gainPercent.toStringAsFixed(2)}%)',
                style: GoogleFonts.inter(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
