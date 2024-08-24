import 'package:flutter/material.dart';

class WeatherAppBar extends StatelessWidget {
  const WeatherAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text('Weather', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                debugPrint('Refresh');
              }),
        ] // actions
        );
  }
}
