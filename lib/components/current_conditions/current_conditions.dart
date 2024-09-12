import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:epcot_weather/services/weather_properties.dart'; // Import DataEngine

class CurrentConditions extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const CurrentConditions({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    //<daily stats>
    final dailyStats = weatherData['daily'];
    final sunrise = dailyStats['sunrise'][0];
    DateTime sunriseTime = DateTime.parse(sunrise);
    final sunset = dailyStats['sunset'][0];
    DateTime sunsetTime = DateTime.parse(sunset);
    //</daily stats>

    final currentConditions = weatherData['current'];
    final time = currentConditions['time'];
    final DateTime currentTime = DateTime.parse(time);
    final temperature = currentConditions['temperature_2m'] ?? 'N/A';
    final weatherCode = currentConditions['weather_code']; // integer
    final condition = WeatherProperties.condition(weatherCode);

    final daylight = (currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime));

    final icon = WeatherProperties.getWeatherIcon(condition, daylight);

    // Parse the timestamp and format it
    final String formattedTime = DateFormat('hh:mm a').format(currentTime);

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              children: [
                Text('As of: $formattedTime', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Text('$temperature°F', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Icon(icon, size: 48),
                const SizedBox(height: 5),
                Text(condition, style: const TextStyle(fontSize: 20)),
              ], // children
            ),
          ),
        ),
      ),
    );
  }
}
