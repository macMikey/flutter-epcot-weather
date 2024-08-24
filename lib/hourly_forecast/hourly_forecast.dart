import 'package:flutter/material.dart';
import 'package:weather/hourly_forecast/hourly_forecast_item.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HourlyForecastItem(hour: "08:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "09:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "10:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "11:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "12:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "13:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "14:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "15:00", icon: Icons.cloud, temperature: "80 °F"),
        ],
      ),
    );
  }
}
