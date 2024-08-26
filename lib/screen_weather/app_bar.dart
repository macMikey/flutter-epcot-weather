// title bar + reload button
// no dynmaic data
// ----------------------------------------------
import 'package:flutter/material.dart';
// ----------------------------------------------

class WeatherAppBar extends StatelessWidget {
  static const appTitle = "EPCOT Weather";
  final VoidCallback onRefresh;

  const WeatherAppBar({
    super.key,
    required this.onRefresh,
  });
// ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(appTitle, style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
