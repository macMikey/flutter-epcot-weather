// title bar + reload button
// no dynmaic data
// ----------------------------------------------
import 'package:flutter/material.dart';
// ----------------------------------------------

class WeatherAppBar extends StatelessWidget {
  static const appTitle = "EPCOT Weather";

  const WeatherAppBar({
    super.key,
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
              onPressed: () {
                //debugPrint('Refresh');
              }),
        ] // actions
        );
  }
}
