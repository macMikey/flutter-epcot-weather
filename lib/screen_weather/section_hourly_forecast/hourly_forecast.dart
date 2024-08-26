import 'package:flutter/material.dart';
import 'package:weather/screen_weather/section_hourly_forecast/hourly_forecast_item.dart';

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
          HourlyForecastItem(hour: "08:00", icon: Icons.wb_sunny, temperature: "80 °F"),
          HourlyForecastItem(hour: "09:00", icon: Icons.cloud, temperature: "80 °F"),
          HourlyForecastItem(hour: "10:00", icon: Icons.grain, temperature: "80 °F"), // looks like blizzard
          HourlyForecastItem(hour: "11:00", icon: Icons.flash_on, temperature: "80 °F"),
          HourlyForecastItem(hour: "12:00", icon: Icons.ac_unit, temperature: "80 °F"), //snowflake
          HourlyForecastItem(hour: "13:00", icon: Icons.air, temperature: "80 °F"), // wind
          HourlyForecastItem(hour: "14:00", icon: Icons.blur_on, temperature: "80 °F"), // no idea. they say foggy
          HourlyForecastItem(hour: "15:00", icon: Icons.nights_stay, temperature: "80 °F"),
          HourlyForecastItem(
              hour: "15:00", icon: Icons.wb_cloudy, temperature: "80 °F"), // cloudy (they say "partly cloudy")
          HourlyForecastItem(hour: "15:00", icon: Icons.thermostat, temperature: "80 °F"),
        ],
      ),
    );
  }
}
