/* * loads WeatherScreen()
   * sets theme
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_notifier.dart'; // Import the ThemeNotifier class
import 'package:weather/screens/weather_screen.dart';
// --------------------------------------------------------------

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}
// --------------------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Converted 'key' to a super parameter

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Removed the debug flag
          themeMode: themeNotifier.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const WeatherScreen(), // Added 'const' to the constructor
        );
      },
    );
  }
  // --------------------------------------------------------------
}
