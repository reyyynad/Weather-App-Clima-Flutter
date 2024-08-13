// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:clima_flutter/screens/city_screen.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  dynamic locationWeather;
  LocationScreen({required this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late int conditionNumber;
  late String weatherImage;
  late String cityName;
  late String weatherMessage;
  late WeatherModel weatherModel;
  late Color weatherColor;

  @override
  void initState() {
    super.initState();
    weatherModel = WeatherModel();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    WeatherModel weatherModel = WeatherModel();
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherImage = 'Error';
        weatherMessage = 'Unable to get weather data';
        conditionNumber = 0; // or any other default value
        cityName = 'Unknown'; // or any other default value
        weatherColor = kLightBlue;
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      conditionNumber = weatherData['weather'][0]['id'];
      weatherImage = weatherModel.getWeatherImage(conditionNumber);
      weatherColor = weatherModel.getWeatherColor(conditionNumber);
      cityName = weatherData['name'];
      weatherMessage = weatherModel.getMessage(temperature, cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: weatherColor,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      print(typedName);
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Center(
                child: Image(
                  image: AssetImage(
                    weatherImage,
                  ),
                  width: 400,
                  height: 400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:clima_flutter/utilities/constants.dart';

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/location_background.jpg'),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(
//                 Colors.white.withOpacity(0.8), BlendMode.dstATop),
//           ),
//         ),
//         constraints: BoxConstraints.expand(),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   TextButton(
//                     onPressed: () {},
//                     child: Icon(
//                       Icons.near_me,
//                       size: 50.0,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Icon(
//                       Icons.location_city,
//                       size: 50.0,
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 15.0),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       '32°',
//                       style: kTempTextStyle,
//                     ),
//                     Text(
//                       '☀️',
//                       style: kConditionTextStyle,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 15.0),
//                 child: Text(
//                   "It's 🍦 time in San Francisco!",
//                   textAlign: TextAlign.right,
//                   style: kMessageTextStyle,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // double tempreture = decodedData['main']['temp'];
// // int conditionNumber = decodedData["weather"][0]['id'];
// // String cityName = decodedData['name'];
