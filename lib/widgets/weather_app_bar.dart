import 'package:flutter/material.dart';

class WeatherAppBar extends StatelessWidget {
  static const appTitle = "EPCOT Weather";
  final VoidCallback onRefresh;
  final Function(BuildContext) onToggleTheme;
  final ThemeMode themeMode;

  const WeatherAppBar({
    super.key,
    required this.onRefresh,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the icon based on the current and system theme
    IconData themeIcon;
    final Brightness systemBrightness = MediaQuery.of(context).platformBrightness;

    if (themeMode == ThemeMode.system) {
      themeIcon = systemBrightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode;
    } else {
      themeIcon = Icons.brightness_auto;
    }

    return AppBar(
      title: const Text(appTitle, style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(themeIcon),
        onPressed: () => onToggleTheme(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
