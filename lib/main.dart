/* * loads WeatherScreen()
   * sets theme
*/
import 'package:flutter/material.dart';
import 'package:weather/weather_screen.dart';
// ----------------------------------------------

void main() {
  runApp(const MyApp());
}
// ----------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}
