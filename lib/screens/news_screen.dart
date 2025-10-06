import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Market News',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade800,
                      Colors.red.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => NewsArticleItem(article: newsArticles[index]),
              childCount: newsArticles.length,
            ),
          ),
        ],
      ),
    );
  }
}

class NewsArticleItem extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(article['category']),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  article['category'],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                article['time'],
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            article['title'],
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            article['summary'],
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.green, size: 16),
              const SizedBox(width: 4),
              Text(
                '${article['impact']} Impact',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                'Read More →',
                style: GoogleFonts.inter(
                  color: Colors.blue.shade300,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Tech':
        return Colors.blue.shade600;
      case 'Markets':
        return Colors.green.shade600;
      case 'Earnings':
        return Colors.orange.shade600;
      case 'Economy':
        return Colors.purple.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}

final List<Map<String, dynamic>> newsArticles = [
  {
    'category': 'Tech',
    'time': '2 hours ago',
    'title': 'Apple Announces Breakthrough in AI Chip Technology',
    'summary': 'Apple unveils new M3 chips with enhanced AI capabilities, expected to revolutionize mobile computing.',
    'impact': 'High',
  },
  {
    'category': 'Markets',
    'time': '4 hours ago',
    'title': 'Federal Reserve Holds Interest Rates Steady',
    'summary': 'The Fed maintains current interest rates, signaling confidence in economic recovery.',
    'impact': 'Medium',
  },
  {
    'category': 'Earnings',
    'time': '6 hours ago',
    'title': 'Tesla Q4 Earnings Beat Expectations',
    'summary': 'Tesla reports record deliveries and stronger-than-expected profitability in latest quarter.',
    'impact': 'High',
  },
  {
    'category': 'Economy',
    'time': '8 hours ago',
    'title': 'Inflation Data Shows Cooling Trend',
    'summary': 'Latest CPI data indicates inflation is moderating faster than anticipated.',
    'impact': 'Medium',
  },
];