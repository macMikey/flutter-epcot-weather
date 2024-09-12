import 'package:epcot_weather/services/weather_properties.dart'; // Import DataEngine
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class CurrentConditions extends StatefulWidget {
  final Map<String, dynamic> weatherData;

  const CurrentConditions({super.key, required this.weatherData});

  @override
  CurrentConditionsState createState() => CurrentConditionsState();
}

class CurrentConditionsState extends State<CurrentConditions> {
  late Timer _timer;
  late DateTime _currentTime;
  late DateTime _forecastTime;
  late DateTime _nextUpdateTime;
  late bool _isUpdateAvailable;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _forecastTime = DateTime.parse(widget.weatherData['current']['time']);
    _nextUpdateTime = _calculateNextUpdateTime(_forecastTime);
    _isUpdateAvailable = DateTime.now().isAfter(_nextUpdateTime);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        _isUpdateAvailable = DateTime.now().isAfter(_nextUpdateTime);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //<daily stats>
    final dailyStats = widget.weatherData['daily'];
    final sunrise = dailyStats['sunrise'][0];
    DateTime sunriseTime = DateTime.parse(sunrise);
    final sunset = dailyStats['sunset'][0];
    DateTime sunsetTime = DateTime.parse(sunset);
    //</daily stats>

    final currentConditions = widget.weatherData['current'];
    final temperature = currentConditions['temperature_2m'] ?? 'N/A';
    final weatherCode = currentConditions['weather_code']; // integer
    final condition = WeatherProperties.condition(weatherCode);

    final daylight = (_currentTime.isAfter(sunriseTime) && _currentTime.isBefore(sunsetTime));

    final icon = WeatherProperties.getWeatherIcon(condition, daylight);

    // Parse the forecast timestamp and format it
    final String formattedForecastTime = DateFormat('hh:mm a').format(_forecastTime);
    final String formattedNextUpdateTime = DateFormat('hh:mm a').format(_nextUpdateTime);

    // Debug prints
    debugPrint('Current Time: $_currentTime');
    debugPrint('Forecast Time: $_forecastTime');
    debugPrint('Next Update Time: $_nextUpdateTime');
    debugPrint('Is Update Available: $_isUpdateAvailable');

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 48),
                  const SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0), // Add padding to bump the text to the right
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$temperature°F',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          condition,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            Text(
                              'As of $formattedForecastTime',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            if (_isUpdateAvailable)
                              const Row(
                                children: [
                                  SizedBox(width: 30),
                                  Icon(Icons.update, color: Colors.green, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'Updated report available',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  const SizedBox(width: 30),
                                  Icon(Icons.access_time,
                                      size: 16, color: Theme.of(context).textTheme.bodySmall?.color),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Next update at $formattedNextUpdateTime',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _calculateNextUpdateTime(DateTime forecastTime) {
    int minute = forecastTime.minute;
    int nextUpdateMinute;

    if (minute < 15) {
      nextUpdateMinute = 15;
    } else if (minute < 30) {
      nextUpdateMinute = 30;
    } else if (minute < 45) {
      nextUpdateMinute = 45;
    } else {
      nextUpdateMinute = 0;
      forecastTime = forecastTime.add(const Duration(hours: 1));
    }

    return DateTime(forecastTime.year, forecastTime.month, forecastTime.day, forecastTime.hour, nextUpdateMinute);
  }
}
