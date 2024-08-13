// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/services/networking.dart';
import 'package:clima_flutter/services/location.dart';

const apiKey = 'ba6d8f3568bda9ba551dc783b6055d0b';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  // check the api website on how you get weather based on cityName
  Future<dynamic> getCityWeather(String cityName) async {
    Networking networking = Networking(
      Uri.parse('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric'),
    );
    var weatherData = await networking.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    Networking networking = await Networking(
      Uri.parse(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'),
    );
    var weatherData = await networking.getData();
    return weatherData;
  }

  Color getWeatherColor(int condition) {
    if (condition < 300) {
      return kPurble;
    } else if (condition < 400) {
      return kPurble;
    } else if (condition < 600) {
      return kPurble;
    } else if (condition < 700) {
      return kBlue;
    } else if (condition < 800) {
      return kPurble;
    } else if (condition == 800) {
      return kLightBlue;
    } else if (condition <= 804) {
      return kLightBlue;
    } else {
      return kPurble;
    }
  }

  String getWeatherImage(int condition) {
    if (condition < 300) {
      return 'images/lightning.png';
    } else if (condition < 400) {
      return 'images/rain.png';
    } else if (condition < 600) {
      return 'images/storm.png';
    } else if (condition < 700) {
      return 'images/snow.png';
    } else if (condition < 800) {
      return 'images/rain.png';
    } else if (condition == 800) {
      return 'images/sun.png';
    } else if (condition <= 804) {
      return 'images/cloud.png';
    } else {
      return 'images/idk.png';
    }
  }

  String getMessage(int temp, String cityName) {
    if (temp > 25) {
      return 'It\'s 🍦 time in $cityName';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in $cityName';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in $cityName';
    } else {
      return 'Bring a 🧥 just in case in $cityName';
    }
  }
}
