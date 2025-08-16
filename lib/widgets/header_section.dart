import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final Animation<Offset> title1Slide;
  final Animation<Offset> title2Slide;
  final Animation<Offset> searchSlide;

  const HeaderSection({
    super.key,
    required this.title1Slide,
    required this.title2Slide,
    required this.searchSlide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideTransition(
            position: title1Slide,
            child: Text(
              "Find Your",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SlideTransition(
            position: title2Slide,
            child: Text(
              "Inspiration",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SlideTransition(
            position: searchSlide,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: theme.colorScheme.surfaceVariant,
              ),
              child: TextField(
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Search what you're looking for",
                  border: InputBorder.none,
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                  icon: Icon(Icons.search,
                      color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
