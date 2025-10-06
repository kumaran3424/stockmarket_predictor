import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillionairesScreen extends StatelessWidget {
  const BillionairesScreen({super.key});

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
                'Forbes Billionaires',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.shade800,
                      Colors.orange.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/images/forbes-bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => BillionaireListItem(billionaire: billionaires[index]),
              childCount: billionaires.length,
            ),
          ),
        ],
      ),
    );
  }
}

class BillionaireListItem extends StatelessWidget {
  final Map<String, dynamic> billionaire;

  const BillionaireListItem({super.key, required this.billionaire});

  @override
  Widget build(BuildContext context) {
    final netWorthChange = billionaire['change'] ?? 0;
    final isPositive = netWorthChange >= 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _getRankColor(billionaire['rank']),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                billionaire['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  billionaire['name'],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  billionaire['company'],
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getRankColor(billionaire['rank']),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '#${billionaire['rank']}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '\$${billionaire['netWorth']}B',
                      style: GoogleFonts.inter(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isPositive ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  Text(
                    '\$${netWorthChange.abs().toStringAsFixed(1)}B',
                    style: GoogleFonts.inter(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                billionaire['industry'],
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return Colors.amber;
    if (rank <= 3) return Colors.orange;
    if (rank <= 10) return Colors.purple;
    return Colors.blue;
  }
}

final List<Map<String, dynamic>> billionaires = [
  {
    'rank': 1,
    'name': 'Elon Musk',
    'company': 'Tesla, SpaceX',
    'netWorth': 245.3,
    'change': 12.5,
    'industry': 'Automotive & Aerospace',
    'image': 'assets/images/elon_musk.jpg',
  },
  {
    'rank': 2,
    'name': 'Jeff Bezos',
    'company': 'Amazon',
    'netWorth': 195.4,
    'change': 8.3,
    'industry': 'E-commerce & Cloud',
    'image': 'assets/images/jeff_bezos.jpg',
  },
  {
    'rank': 3,
    'name': 'Bernard Arnault',
    'company': 'LVMH',
    'netWorth': 188.7,
    'change': -2.1,
    'industry': 'Luxury Goods',
    'image': 'assets/images/bernard_arnault.jpg',
  },
  {
    'rank': 4,
    'name': 'Bill Gates',
    'company': 'Microsoft',
    'netWorth': 125.8,
    'change': 3.4,
    'industry': 'Software & Philanthropy',
    'image': 'assets/images/bill_gates.jpg',
  },
  {
    'rank': 5,
    'name': 'Mark Zuckerberg',
    'company': 'Meta',
    'netWorth': 118.6,
    'change': 15.2,
    'industry': 'Social Media',
    'image': 'assets/images/mark_zuckerberg.jpg',
  },
];