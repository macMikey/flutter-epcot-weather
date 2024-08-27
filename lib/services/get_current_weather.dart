/*
fnctions:
  - condition(int weatherCode) => String
  - getWeatherIcon(String condition, bool daylight) => IconData
  - getCurrentWeather(double lat, double lon) => Future<Map<String, dynamic>>
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ==============================================================

class GetCurrentWeather {
  static String condition(int weatherCode) {
    /* WMO Weather interpretation codes (WW)
    https://open-meteo.com/en/docs
    */
    switch (weatherCode) {
      case 0:
        return 'Clear';
      case 1:
        return 'Mostly Clear';
      case 2:
        return 'Partly Cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Fog';
      case 51:
      case 61:
      case 53:
      case 63:
      case 55:
      case 65:
      case 80:
      case 81:
      case 82:
        return 'Rain';
      case 56:
      case 57:
        return 'Freezing Rain';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return 'Snow';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorm';
      default:
        return 'Unknown';
    }
  }
// --------------------------------------------------------------

  static IconData getWeatherIcon(String condition, bool daylight) {
    switch (condition.toLowerCase()) {
      case 'cloudy':
        if (!daylight) {
          return Icons.nights_stay;
        } else {
          return Icons.cloud;
        }
      case 'mostly cloudy':
      case 'overcast':
        return Icons.cloud;
      case 'partly cloudy':
        return Icons.wb_cloudy;
      case 'clear':
      case 'mostly clear':
        if (daylight) {
          return Icons.wb_sunny;
        } else {
          return Icons.bedtime;
        }
      case 'rain':
        return Icons.beach_access;
      case 'snow':
      case 'freezing rain':
        return Icons.ac_unit;
      case 'fog':
        return Icons.cloud_queue;
      case 'thunderstorm':
        return Icons.flash_on;
      default:
        return Icons.help_outline;
    }
  }
// --------------------------------------------------------------

  static Future<Map<String, dynamic>> getCurrentWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,precipitation,rain,showers,snowfall,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m&daily=sunrise,sunset&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=America%2FNew_York&forecast_days=1"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
