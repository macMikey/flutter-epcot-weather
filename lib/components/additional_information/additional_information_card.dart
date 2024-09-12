import 'package:flutter/material.dart';
import 'package:epcot_weather/components/additional_information/additional_info_item.dart';

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard({super.key, required this.weatherData});

  final Map<String, dynamic>? weatherData;

  @override
  Widget build(BuildContext context) {
    final currentConditions = weatherData?['current'];
    final windSpeed = currentConditions?['wind_speed_10m'] ?? 'N/A';
    final humidity = currentConditions?['relative_humidity_2m'] ?? 'N/A';
    final surfacePressure = currentConditions?['surface_pressure'] != null
        ? (currentConditions['surface_pressure'] * 0.02953).toStringAsFixed(2)
        : 'N/A';

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AdditionalInfoItem(icon: Icons.air, label: "Wind", value: "$windSpeed mph"),
          AdditionalInfoItem(icon: Icons.water_drop, label: "Humidity", value: "$humidity%"),
          AdditionalInfoItem(icon: Icons.speed, label: "Pressure", value: "$surfacePressure inHg"),
        ],
      ),
    );
  }
}
