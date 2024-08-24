import 'package:flutter/material.dart';
import 'package:weather/additional_information/additional_info_item.dart';

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AdditionalInfoItem(icon: Icons.air, label: "Wind", value: "5 mph"),
          AdditionalInfoItem(icon: Icons.water_drop, label: "Humidity", value: "60%"),
          AdditionalInfoItem(icon: Icons.speed, label: "Pressure", value: "1013 hPa"),
        ],
      ),
    );
  }
}
