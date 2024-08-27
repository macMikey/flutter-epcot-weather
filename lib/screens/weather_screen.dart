/* Main screen.
    * polls server
    * displays:
      * App_bar()
      * AppBody()
*/
// ----------------------------------------------

import 'package:weather/components/app_body.dart';
import 'package:weather/widgets/weather_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/theme_notifier.dart'; // Import the ThemeNotifier class
import 'package:weather/services/get_current_weather.dart'; // Import the GetCurrentWeather class
// ----------------------------------------------

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}
// ----------------------------------------------

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }
// ----------------------------------------------

  Future<void> getCurrentWeather() async {
    var lat = 28.376824;
    var lon = -81.549395;

    try {
      final data = await GetCurrentWeather.getCurrentWeather(lat, lon);

      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch weather data: $e";
        _isLoading = false;
      });
    }
  }

// ----------------------------------------------

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    if (_isLoading) {
      return _waitingIndicator(themeNotifier.themeMode);
    } else if (_errorMessage != null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: WeatherAppBar(
            onRefresh: getCurrentWeather,
            onToggleTheme: _toggleTheme,
            themeMode: themeNotifier.themeMode,
          ),
        ),
        body: Center(child: Text(_errorMessage!)),
      );
    } else {
      return _buildScaffold(_weatherData, themeNotifier.themeMode);
    }
  }
// ----------------------------------------------
// ----------------------------------------------
// ----------------------------------------------

  // the main screen: app bar and body
  Scaffold _buildScaffold(Map<String, dynamic>? weatherData, ThemeMode themeMode) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: WeatherAppBar(
          onRefresh: getCurrentWeather,
          onToggleTheme: _toggleTheme,
          themeMode: themeMode,
        ),
      ),
      body: AppBody(weatherData: weatherData),
    );
  }
// ----------------------------------------------

  // circular waiting indicator
  Widget _waitingIndicator(ThemeMode themeMode) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: WeatherAppBar(
          onRefresh: getCurrentWeather,
          onToggleTheme: _toggleTheme,
          themeMode: themeMode,
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 16),
            Text('Loading weather data...', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
// ----------------------------------------------

  // Implementation of _toggleTheme using Provider
  void _toggleTheme(BuildContext context) {
    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme(context);
  }
} // _WeatherScreenState
//</debugx>