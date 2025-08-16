import 'package:flutter/material.dart';
import 'package:inspirational_app_ui/widgets/animated_appbar.dart';
import 'package:inspirational_app_ui/widgets/bottom_navbar.dart';

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;

  late Animation<Offset> _appBarSlide;
  late Animation<double> _appBarFade;
  late Animation<Offset> _title1Slide;
  late Animation<Offset> _title2Slide;
  late Animation<Offset> _searchSlide;
  late List<Animation<double>> _promoCardScales;
  late List<Animation<double>> _promoCardFades;
  late Animation<double> _bannerScale;
  late Animation<Offset> _bottomNavSlide;

  final List<String> _promoImages = const [
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // AppBar
    _appBarSlide = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.15, curve: Curves.easeOut)));
    _appBarFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn)));

    // Headers
    _title1Slide = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.15, 0.3, curve: Curves.easeOut)));
    _title2Slide = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.4, curve: Curves.easeOut)));
    _searchSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.35, 0.5, curve: Curves.easeOut)));

    // Promo
    _promoCardScales = List.generate(6, (index) {
      final start = 0.5 + (index * 0.05);
      final end = start + 0.15;
      return Tween<double>(begin: 0.8, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOutBack)));
    });
    _promoCardFades = List.generate(6, (index) {
      final start = 0.5 + (index * 0.05);
      final end = start + 0.15;
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn)));
    });

    // Banner
    _bannerScale = Tween<double>(begin: 0.8, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 0.9, curve: Curves.easeOutBack)));

    // Bottom Nav
    _bottomNavSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.9, 1.0, curve: Curves.easeOut)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AnimatedAppBar(
        slide: _appBarSlide,
        fade: _appBarFade,
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
                HeaderSection(
                  title1Slide: _title1Slide,
                  title2Slide: _title2Slide,
                  searchSlide: _searchSlide,
                ),
                const SizedBox(height: 20),
                PromoSection(
                  controller: _controller,
                  promoImages: _promoImages,
                  scales: _promoCardScales,
                  fades: _promoCardFades,
                ),
                const SizedBox(height: 20),
                BannerCard(scale: _bannerScale),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavTapped,
        slide: _bottomNavSlide,
      ),
    );
  }
}
