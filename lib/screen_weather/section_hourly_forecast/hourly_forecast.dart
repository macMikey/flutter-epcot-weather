import 'package:flutter/material.dart';
import 'package:weather/screen_weather/section_hourly_forecast/hourly_forecast_item.dart';
import 'package:weather/data_engine.dart';
import 'package:intl/intl.dart';
// ==============================================================

class HourlyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const HourlyForecast({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final int nextHourlyIndex = _nextHourlyTimeIndex(weatherData);
    final List<dynamic> hourlyData = weatherData['hourly']['time'];
    final List<dynamic> hourlyWeatherCodes = weatherData['hourly']['weather_code'];
    final List<dynamic> hourlyTemperatures = weatherData['hourly']['temperature_2m'];

    // Filter hourly data to include only the remaining hours of the day
    final DateTime currentTime = DateTime.parse(weatherData['current']['time']);
    final sunsetTime = DateTime.parse(weatherData['daily']['sunset'][0]);
    final numHoursRemaining = hourlyData.length - nextHourlyIndex;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(numHoursRemaining, (index) {
          var currentIndex = nextHourlyIndex + index;
          final String hour = hourlyData[currentIndex];
          final int weatherCode = hourlyWeatherCodes[currentIndex];
          final double temperature = hourlyTemperatures[currentIndex];

          final String condition = DataEngine.condition(weatherCode);
          final bool daylight = currentTime.isBefore(sunsetTime);
          final IconData icon = DataEngine.getWeatherIcon(condition, daylight);

          // Format time to HH:MM AM/PM
          final DateTime hourTime = DateTime.parse(hour);
          final String formattedHour = DateFormat('hh:mm a').format(hourTime);

          // Round temperature to whole number
          final String roundedTemperature = temperature.round().toString();

          return HourlyForecastItem(
            hour: formattedHour,
            icon: icon,
            temperature: '$roundedTemperature°F',
          );
        }),
      ),
    );
  }
// --------------------------------------------------------------

  int _nextHourlyTimeIndex(Map<String, dynamic> weatherData) {
    final String currentTimeString = weatherData['current']['time'];
    final DateTime currentTime = DateTime.parse(currentTimeString);
    final List<String> hourlyTimes = List<String>.from(weatherData['hourly']['time']);

    final int index = hourlyTimes.indexWhere((hourlyTimeString) {
      final DateTime hourlyTime = DateTime.parse(hourlyTimeString);
      return hourlyTime.isAfter(currentTime);
    });

    return index;
  }
  // --------------------------------------------------------------
}
