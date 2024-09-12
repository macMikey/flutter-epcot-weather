import 'package:flutter/material.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefresh;
  final Function(BuildContext) onToggleTheme;
  final ThemeMode themeMode;
  final bool isRefreshing; // Add a parameter to track the refreshing state

  const WeatherAppBar({
    super.key,
    required this.onRefresh,
    required this.onToggleTheme,
    required this.themeMode,
    required this.isRefreshing, // Initialize the parameter
  });

  @override
  Widget build(BuildContext context) {
    // Determine the icon based on the current and system theme
    IconData themeIcon;
    final Brightness systemBrightness = MediaQuery.of(context).platformBrightness;

    if (themeMode == ThemeMode.system) {
      themeIcon = systemBrightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode;
    } else {
      themeIcon = systemBrightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode;
      //themeIcon = Icons.brightness_auto; // if we instead want to show the system theme icon
    }

    return AppBar(
      title: const Text("EPCOT Weather", style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(themeIcon),
        onPressed: () => onToggleTheme(context),
      ),
      actions: [
        if (isRefreshing)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        else
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
