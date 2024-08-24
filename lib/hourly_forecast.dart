import 'package:flutter/material.dart';
import 'package:weather/hourly_forecast_card.dart';

class hourlyForecast extends StatelessWidget {
  const hourlyForecast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HourlyForecastItem(),
          HourlyForecastItem(),
          HourlyForecastItem(),
          HourlyForecastItem(),
          HourlyForecastItem(),
          HourlyForecastItem()
        ],
      ),
    );
  }
}
