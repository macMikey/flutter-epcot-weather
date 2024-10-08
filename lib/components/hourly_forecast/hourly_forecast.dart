import 'package:flutter/material.dart';
import 'package:epcot_weather/components/hourly_forecast/hourly_forecast_item.dart';
import 'package:epcot_weather/services/weather_properties.dart';
import 'package:intl/intl.dart';
// ==============================================================

class HourlyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const HourlyForecast({
    super.key,
    required this.weatherData,
  });
// --------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final String currentTimeString = weatherData['current']['time'] ?? '';
    final sunriseTime = DateTime.parse(weatherData['daily']['sunrise'][0]);
    final sunsetTime = DateTime.parse(weatherData['daily']['sunset'][0]);

    final int thisHourlyIndex = _thisHourlyTimeIndex(currentTimeString); // forecast starts ...now
    final List<dynamic> hourlyData = weatherData['hourly']['time'];
    final numHoursRemaining = hourlyData.length - thisHourlyIndex; // in the day

    final List<dynamic> hourlyWeatherCodes = weatherData['hourly']['weather_code'];
    final List<dynamic> hourlyTemperatures = weatherData['hourly']['temperature_2m'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(numHoursRemaining, (index) {
          var currentIndex = thisHourlyIndex + index;
          final DateTime hour = DateTime.parse(hourlyData[currentIndex]);
          final int weatherCode = hourlyWeatherCodes[currentIndex];
          final int temperature = hourlyTemperatures[currentIndex].round();

          final String condition = WeatherProperties.condition(weatherCode);
          final bool daylight = dateTimeGTEQ(hour, sunriseTime) && dateTimeLTEQ(hour, sunsetTime);
          final IconData icon = WeatherProperties.getWeatherIcon(condition, daylight);

          // Format time to HH:MM AM/PM
          final String formattedHour = DateFormat('hh:mm a').format(hour);

          List<Widget> widgets = [];

          // Add the current hour's widget(s) - if sunrise or sunset happens, add that after current hour's forecast
          widgets.add(HourlyForecastItem(
            hour: formattedHour,
            icon: icon,
            temperature: '$temperature°F',
          ));

          // Check if sunrise or sunset should be displayed before the next hour
          if (currentIndex + 1 < hourlyData.length) {
            final DateTime nextHour = DateTime.parse(hourlyData[currentIndex + 1]);
            if (dateTimeGTEQ(sunriseTime, hour) && dateTimeLTEQ(sunriseTime, nextHour)) {
              widgets.add(_buildSunriseSunsetBox('Sunrise'));
            }
            if (dateTimeGTEQ(sunsetTime, hour) && dateTimeLTEQ(sunsetTime, nextHour)) {
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
// --------------------------------------------------------------

  int _thisHourlyTimeIndex(String currentTimeString) {
    final DateTime currentTime = DateTime.parse(currentTimeString);
    final List<String> hourlyTimes = List<String>.from(weatherData['hourly']['time']);

    int index = -1;
    for (int i = 0; i < hourlyTimes.length; i++) {
      final DateTime hourlyTime = DateTime.parse(hourlyTimes[i]);
      if (dateTimeLTEQ(hourlyTime, currentTime)) {
        index = i;
      } else {
        break;
      }
    }

    return index;
  }
  // --------------------------------------------------------------

  bool dateTimeLTEQ(DateTime a, DateTime b) {
    return a.isBefore(b) || a.isAtSameMomentAs(b);
  }
  // --------------------------------------------------------------

  bool dateTimeGTEQ(DateTime a, DateTime b) {
    return a.isAfter(b) || a.isAtSameMomentAs(b);
  }
// --------------------------------------------------------------

  Widget _buildSunriseSunsetBox(String label) {
    // builds box with vertical text
    return SizedBox(
      width: 20, // Adjust the width as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: label.split('').map((char) => Text(char)).toList(),
      ),
    );
  }
  // --------------------------------------------------------------
}
