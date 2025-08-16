import 'package:flutter/material.dart';
import 'promo_card.dart';

class PromoSection extends StatefulWidget {
  final List<String> promoImages;

  const PromoSection({super.key, required this.promoImages});

  @override
  State<PromoSection> createState() => _PromoSectionState();
}

class _PromoSectionState extends State<PromoSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _scales;
  late List<Animation<double>> _fades;
  late Animation<double> _textFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    final count = widget.promoImages.length;

    _scales = List.generate(count, (index) {
      final start = 0.5 + (index * 0.05);
      final end = start + 0.15;
      return Tween<double>(begin: 0.8, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOutBack)));
    });

    _fades = List.generate(count, (index) {
      final start = 0.5 + (index * 0.05);
      final end = start + 0.15;
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn)));
    });
    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.95, 1.0, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _textFade.value,
                child: Text(
                  "Promo Today",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.promoImages.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fades[index].value,
                      child: Transform.scale(
                        scale: _scales[index].value,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: PromoCard(
                            image: "assets/images/${widget.promoImages[index]}",
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
