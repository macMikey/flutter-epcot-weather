import 'package:flutter/material.dart';
import 'package:weather/additional_information/additional_information_card.dart';
import 'package:weather/current_conditions.dart';
import 'package:weather/hourly_forecast/hourly_forecast.dart';

class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CurrentConditions(),
          SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Hourly Forecast', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          SizedBox(height: 4),
          HourlyForecast(),
          SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Additional Information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          SizedBox(height: 8),
          AdditionalInfoCard(),
        ],
      ),
    );
  }
}
