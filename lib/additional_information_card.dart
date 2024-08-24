import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Card(
        // 3 segments. don't gap the segments
        // icon
        // characteristic
        // value

        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Wind', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Icon(Icons.air, size: 32),
                  SizedBox(height: 8),
                  Text('10 mph', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Humidity', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Icon(Icons.opacity, size: 32),
                  SizedBox(height: 8),
                  Text('80%', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Pressure', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  FaIcon(FontAwesomeIcons.gaugeHigh, size: 20),
                  SizedBox(height: 8),
                  Text('29.92 inHg', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} // WeatherScreen
