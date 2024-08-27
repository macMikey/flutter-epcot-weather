/* * loads WeatherScreen()
   * sets theme
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart'; // Import the ThemeNotifier class
import 'package:weather/screen_weather/weather_screen.dart';
// --------------------------------------------------------------

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}
// --------------------------------------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          themeMode: themeNotifier.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: WeatherScreen(),
        );
      },
    );
  }
  // --------------------------------------------------------------
}
