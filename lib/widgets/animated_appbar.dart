import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Animation<Offset> slide;
  final Animation<double> fade;
  final VoidCallback onThemeToggle;
  final ThemeMode themeMode;

  const AnimatedAppBar({
    super.key,
    required this.slide,
    required this.fade,
    required this.onThemeToggle,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: fade,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AppBar(
              backgroundColor: theme.colorScheme.surface.withOpacity(0.15),
              elevation: 0,
              title: Text(
                "Inspire Hub 🔥",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: theme.colorScheme.surface.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.menu,
                          color: theme.colorScheme.onSurface),
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: theme.colorScheme.surface.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: onThemeToggle,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          themeMode == ThemeMode.dark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
