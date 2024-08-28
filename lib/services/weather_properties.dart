/*
functions:
  - condition(int weatherCode) => String
  - getWeatherIcon(String condition, bool daylight) => IconData
*/

import 'package:flutter/material.dart';
// ==============================================================

class WeatherProperties {
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
}
