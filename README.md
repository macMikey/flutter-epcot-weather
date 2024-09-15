# EPCOT Weather

beginnerish flutter project

* significant co-writing performed by github copilot
* used material design asthetic and controls
* starts with system theme (light/dark)
* connects to open-meteo weather service
* displays current weather at EPCOT
* button to switch theme (light/dark)
* button to reload (server updates data every 15 minutes. app does not auto-refetch)
* hourly forecast ribbon/horizontal scroller for the remainder of the day, including sunrise/sunset markers, if relevant
* switches day/night icons
* displays additional information for current conditions (wind, humidity, pressure)

Dark | Light
-- | --
<img src="https://github.com/macMikey/flutter-epcot-weather/blob/main/screenshots/darkmode.png" /> | <img src="https://github.com/macMikey/flutter-epcot-weather/blob/main/screenshots/lightmode.png" />



## Version History

### 1.0.5+11

* added copyright, read from another yaml file

  

### 1.0.4+10

* added update available indicator, and display next update time



### 1.0.3+8

* refresh indicator more prominent
* pull-down-to-refresh 



### 1.0.2 +6

* round pressure



### 1.0.1+5

* convert pressure to inHg
* ios build works
* minor other stuff



### 1.0.0 09/11/24

* first version that runs on a physical device
