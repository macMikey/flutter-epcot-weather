/* Main screen.
    * polls server
    * displays:
      * App_bar()
      * AppBody()
*/
// ----------------------------------------------

import 'dart:convert';
import 'package:weather/screen_weather/app_body.dart';
import 'package:weather/screen_weather/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather/theme_notifier.dart'; // Import the ThemeNotifier class
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
    http.Response? res;

    try {
      res = await http.get(Uri.parse(
          "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,precipitation,rain,showers,snowfall,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m&daily=sunrise,sunset&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=America%2FNew_York&forecast_days=1"));

      final data = jsonDecode(res.body);
      final statusCode = res.statusCode;

      if (statusCode != 200) {
        setState(() {
          _errorMessage = 'Error $statusCode, ${data['reason']}';
          _isLoading = false;
        });
        return;
      }

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
    /*
    //<debugx> // for barfing res contents after fetching
    var jsonResponse = jsonDecode(res.body);
    var prettyString = const JsonEncoder.withIndent('  ').convert(jsonResponse);
    debugPrint(prettyString);
    //</debugx>
    */
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