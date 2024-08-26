import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentConditions extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const CurrentConditions({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    //debugPrint('------------------------------------');
    //<daily stats (sunrise/sunset)>
    final dailyStats = weatherData['daily'];
    //debugPrint('dailyStats: $dailyStats');
    //debugPrint('dailyStats["sunrise"][0]: ${dailyStats['sunrise'][0]}');
    final sunrise = dailyStats['sunrise'][0];
    DateTime sunriseTime = DateTime.parse(sunrise);
    //debugPrint('sunrise: $sunrise');
    final sunset = dailyStats['sunset'][0];
    DateTime sunsetTime = DateTime.parse(sunset);
    //debugPrint('sunset: $sunset');
    //</daily stats (sunrise/sunset)>

    final currentConditions = weatherData['current'];
    final time = currentConditions['time'];
    final DateTime currentTime = DateTime.parse(time);

    final temperature = currentConditions['temperature_2m'] ?? 'N/A';
    //debugPrint('temperature: $temperature');
    final weatherCode = currentConditions['weather_code'];
    //debugPrint('weatherCode: $weatherCode');
    final condition = _condition(weatherCode);
    //debugPrint('condition: $condition');

    final daylight = (currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime));
    final icon = _getWeatherIcon(condition, daylight);

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
                Text(formattedTime, style: const TextStyle(fontSize: 20)),
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
// ----------------------------------------------

  String _condition(int weatherCode) {
    /* WMO Weather interpretation codes (WW)
    https://open-meteo.com/en/docs
    */
    switch (weatherCode) {
      case 0:
        return 'Clear';
      case 1:
        return 'Mostly Clear';
      case 2:
        return 'Partly Cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Fog';
      case 51:
      case 61:
      case 53:
      case 63:
      case 55:
      case 65:
      case 80:
      case 81:
      case 82:
        return 'Rain';
      case 56:
      case 57:
        return 'Freezing Rain';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return 'Snow';

      default:
        return 'Unknown';
    }
  }

  IconData _getWeatherIcon(String condition, bool daylight) {
    switch (condition.toLowerCase()) {
      case 'cloudy':
        if (!daylight) {
          return Icons.nights_stay;
        } else {
          return Icons.cloud;
        }
      case 'mostly cloudy':
      case 'overcast':
        return Icons.cloud;
      case 'partly cloudy':
        return Icons.wb_cloudy;
      case 'clear':
      case 'mostly clear':
        if (daylight) {
          return Icons.wb_sunny;
        } else {
          return Icons.bedtime;
        }
      case 'rain':
        return Icons.beach_access;
      case 'snow':
      case 'freezing rain':
        return Icons.ac_unit;
      case 'fog':
        return Icons.cloud_queue;
      default:
        return Icons.help_outline;
    }
  }
}
