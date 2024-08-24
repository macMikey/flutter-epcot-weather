//import 'dart:io';
import 'package:weather/app_body.dart';
import 'package:weather/app_bar.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: WeatherAppBar(),
      ),
      body: AppBody(),
    );
  } // build
}
