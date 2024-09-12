import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:epcot_weather/components/app_body.dart';
import 'package:epcot_weather/widgets/weather_app_bar.dart';
import 'package:epcot_weather/providers/theme_notifier.dart';
import 'package:package_info_plus/package_info_plus.dart'; // Import the package

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;
  bool _isRefreshing = false; // Track the refreshing state
  String? _errorMessage;
  String? _versionInfo; // Variable to hold version info

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
    _fetchVersionInfo(); // Fetch version info
  }

  Future<void> _fetchVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _versionInfo = '${packageInfo.version}+${packageInfo.buildNumber}';
    });
  }

  Future<void> getCurrentWeather() async {
    setState(() {
      _isRefreshing = true; // Start refreshing
    });

    var lat = 28.376824;
    var lon = -81.549395;
    http.Response? res;

    try {
      res = await http.get(Uri.parse(
          "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,precipitation,rain,showers,snowfall,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m&daily=sunrise,sunset&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=America%2FNew_York&forecast_days=1"));

      final data = jsonDecode(res.body);
      final statusCode = res.statusCode;

      // Debug print the data retrieved from the server
      final formattedData = const JsonEncoder.withIndent('  ').convert(data);
      debugPrint('Weather Data Retrieved:\n$formattedData');

      if (statusCode != 200) {
        setState(() {
          _errorMessage = 'Error $statusCode, ${data['reason']}';
          _isLoading = false;
          _isRefreshing = false; // Stop refreshing
        });
        return;
      }

      setState(() {
        _weatherData = data;
        _isLoading = false;
        _isRefreshing = false; // Stop refreshing
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch weather data: $e";
        _isLoading = false;
        _isRefreshing = false; // Stop refreshing
      });
    }
  }

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
            onToggleTheme: (context) => _toggleTheme(context),
            themeMode: themeNotifier.themeMode,
            isRefreshing: _isRefreshing, // Pass the refreshing state
          ),
        ),
        body: Center(child: Text(_errorMessage!)),
        bottomNavigationBar: _versionInfoWidget(), // Add version info widget
      );
    } else {
      return _buildScaffold(_weatherData, themeNotifier.themeMode);
    }
  }

  Scaffold _buildScaffold(Map<String, dynamic>? weatherData, ThemeMode themeMode) {
    return Scaffold(
      appBar: _appBar(themeMode),
      body: RefreshIndicator(
        onRefresh: getCurrentWeather,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: AppBody(weatherData: weatherData),
        ),
      ),
      bottomNavigationBar: _versionInfoWidget(), // Add version info widget
    );
  }

  Widget _waitingIndicator(ThemeMode themeMode) {
    return Scaffold(
      appBar: _appBar(themeMode),
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
      bottomNavigationBar: _versionInfoWidget(), // Add version info widget
    );
  }

  PreferredSize _appBar(ThemeMode themeMode) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: WeatherAppBar(
        onRefresh: getCurrentWeather,
        onToggleTheme: (context) => _toggleTheme(context),
        themeMode: themeMode,
        isRefreshing: _isRefreshing, // Pass the refreshing state
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    themeNotifier.toggleTheme(context);
  }

  Widget _versionInfoWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _versionInfo != null ? 'Version: $_versionInfo' : 'Loading version...',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
