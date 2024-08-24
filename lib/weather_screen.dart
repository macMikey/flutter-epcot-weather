//import 'dart:io';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Weather', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  debugPrint('Refresh');
                }),
          ] // actions
          ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //current conditions
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: const Column(
                      children: [
                        Text('80 °F', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        Icon(Icons.cloud, size: 64),
                        SizedBox(height: 16),
                        Text('Cloudy', style: TextStyle(fontSize: 20)),
                      ], // children
                    ),
                  ),
                ),
              ),
            ),
            //</current conditions>

            const SizedBox(height: 20),

            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Hourly Forecast', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),

            const SizedBox(height: 16),

            //<hourly forecast cards>
            const SingleChildScrollView(
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
            ),
            //</hourly forecast cards>

            const SizedBox(height: 20),

            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Additional Information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),

            const SizedBox(height: 16),

            //<additional information>
            const SizedBox(
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
            ),
            //</additional information>
          ],
        ),
      ),
    );
  } // build
} // WeatherScreen

class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          children: [
            Text('08:00', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Icon(Icons.cloud, size: 32),
            SizedBox(height: 8),
            Text('80 °F'),
          ],
        ),
      ),
    );
  }
}
