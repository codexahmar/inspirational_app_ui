import 'package:flutter/material.dart';
import 'promo_card.dart';

class PromoSection extends StatelessWidget {
  final AnimationController controller;
  final List<String> promoImages;
  final List<Animation<double>> scales;
  final List<Animation<double>> fades;

  const PromoSection({
    super.key,
    required this.controller,
    required this.promoImages,
    required this.scales,
    required this.fades,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Today",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: promoImages.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: fades[index].value,
                      child: Transform.scale(
                        scale: scales[index].value,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: PromoCard(
                            image: "assets/images/${promoImages[index]}",
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
