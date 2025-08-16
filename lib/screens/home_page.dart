import 'package:flutter/material.dart';
import 'package:inspirational_app_ui/widgets/animated_appbar.dart';
import 'package:inspirational_app_ui/widgets/bottom_navbar.dart';
import 'package:inspirational_app_ui/widgets/qoute_card.dart';
import '../widgets/header_section.dart';
import '../widgets/promo_section.dart';
import '../widgets/banner_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode themeMode;
  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.themeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> _promoImages = const [
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '6.jpg',
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AnimatedAppBar(
        onThemeToggle: widget.onThemeToggle,
        themeMode: widget.themeMode,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(),
                const SizedBox(height: 20),
                PromoSection(
                  promoImages: _promoImages,
                ),
                const SizedBox(height: 20),
                BannerCard(),
                const SizedBox(height: 20),
                QuoteCard(
                  quote:
                      '"The best way to get started is to quit talking and begin doing."',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}
