/* displays:
     CurrentConditions()
     HourlyForecast()
     AdditionalInfoCard()
*/
import 'package:flutter/material.dart';
import 'package:weather/screen_weather/section_additional_information/additional_information_card.dart';
import 'package:weather/screen_weather/section_current_conditions/current_conditions.dart';
import 'package:weather/screen_weather/section_hourly_forecast/hourly_forecast.dart';

class AppBody extends StatelessWidget {
  final Map<String, dynamic>? weatherData;
  const AppBody({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CurrentConditions(weatherData: weatherData ?? {}),
          const SizedBox(height: 20),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Hourly Forecast', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 4),
          HourlyForecast(weatherData: weatherData ?? {}),
          const SizedBox(height: 20),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Additional Information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 8),
          AdditionalInfoCard(weatherData: weatherData ?? {}),
        ],
      ),
    );
  }
}
