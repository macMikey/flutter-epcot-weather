import 'package:flutter/material.dart';
import 'package:weather/screen_weather/section_hourly_forecast/hourly_forecast_item.dart';
import 'package:weather/data_engine.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const HourlyForecast({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final String currentTimeString = weatherData['current']['time'] ?? '';
    final int nextHourlyIndex = _nextHourlyTimeIndex(currentTimeString);
    final List<dynamic> hourlyData = weatherData['hourly']['time'];
    final List<dynamic> hourlyWeatherCodes = weatherData['hourly']['weather_code'];
    final List<dynamic> hourlyTemperatures = weatherData['hourly']['temperature_2m'];

    // Filter hourly data to include only the remaining hours of the day
    final sunriseTime = DateTime.parse(weatherData['daily']['sunrise'][0]);
    final sunsetTime = DateTime.parse(weatherData['daily']['sunset'][0]);
    final numHoursRemaining = hourlyData.length - nextHourlyIndex;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(numHoursRemaining, (index) {
          var currentIndex = nextHourlyIndex + index;
          final DateTime hour = DateTime.parse(hourlyData[currentIndex]);
          final int weatherCode = hourlyWeatherCodes[currentIndex];
          final double temperature = hourlyTemperatures[currentIndex];

          final String condition = DataEngine.condition(weatherCode);
          final bool daylight = hour.isAfter(sunriseTime) && hour.isBefore(sunsetTime);
          final IconData icon = DataEngine.getWeatherIcon(condition, daylight);

          // Format time to HH:MM AM/PM
          final String formattedHour = DateFormat('hh:mm a').format(hour);

          List<Widget> widgets = [];

          // Add the current hour's widget
          widgets.add(HourlyForecastItem(
            hour: formattedHour,
            icon: icon,
            temperature: '$temperature°F',
          ));

          // Check if sunrise or sunset should be displayed before the next hour
          if (currentIndex + 1 < hourlyData.length) {
            final DateTime nextHour = DateTime.parse(hourlyData[currentIndex + 1]);
            if (sunriseTime.isAfter(hour) && sunriseTime.isBefore(nextHour)) {
              widgets.add(_buildSunriseSunsetBox('Sunrise'));
            }
            if (sunsetTime.isAfter(hour) && sunsetTime.isBefore(nextHour)) {
              widgets.add(_buildSunriseSunsetBox('Sunset'));
            }
          }

          return Row(
            children: widgets,
          );
        }),
      ),
    );
  }

  int _nextHourlyTimeIndex(String currentTimeString) {
    final DateTime currentTime = DateTime.parse(currentTimeString);
    final List<String> hourlyTimes = List<String>.from(weatherData['hourly']['time']);

    final int index = hourlyTimes.indexWhere((hourlyTimeString) {
      final DateTime hourlyTime = DateTime.parse(hourlyTimeString);
      return hourlyTime.isAfter(currentTime);
    });

    return index;
  }

  Widget _buildSunriseSunsetBox(String label) {
    return Container(
      width: 20, // Adjust the width as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: label.split('').map((char) => Text(char)).toList(),
      ),
    );
  }
}
