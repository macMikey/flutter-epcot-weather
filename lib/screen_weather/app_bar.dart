// title bar + reload button
// no dynmaic data
import 'package:flutter/material.dart';
// ----------------------------------------------

class WeatherAppBar extends StatelessWidget {
  static const appTitle = "EPCOT Weather";
  final VoidCallback onRefresh;
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const WeatherAppBar({
    super.key,
    required this.onRefresh,
    required this.onToggleTheme,
    required this.themeMode,
  });
// ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    IconData themeIcon;
    if (themeMode == ThemeMode.dark) {
      themeIcon = Icons.dark_mode;
    } else if (themeMode == ThemeMode.light) {
      themeIcon = Icons.light_mode;
    } else {
      themeIcon = Icons.brightness_auto;
    }

    return AppBar(
      title: const Text(appTitle, style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(themeIcon),
        onPressed: onToggleTheme,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
        ),
      ],
    );
  }
  // ----------------------------------------------
}
