import 'package:flutter/material.dart';
import 'package:weather_app1/screens/city_screen.dart';
import 'package:weather_app1/utilities/constants.dart';
import 'dart:convert';
import 'package:weather_app1/services/weather.dart';

class LocationScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int condition = 0;
  int temperature = 0;
  String cityName = '';

  WeatherModel wm = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(String weatherData) {
    setState(() {
      // ignore: unnecessary_null_comparison
      if (weatherData == null) {
        temperature = 0;
        condition = 0;
        cityName = '';
        return;
      }
      condition = jsonDecode(weatherData)['weather'][0]['id'];
      temperature = jsonDecode(weatherData)['main']['temp'].toInt();
      cityName = jsonDecode(weatherData)['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
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
                      var weatherData = await wm.getLocationWeather();
                      updateUI(weatherData);
                      //print(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var nameType = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CityScreen();
                      }));
                      if (nameType != null) {
                        var cityWeather = await wm.getCityNameWeather(nameType);
                        updateUI(cityWeather);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      wm.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "${wm.getMessage(temperature)} in $cityName",
                  //"It's ${wm.getMessage(temperature)} time in $cityName",
                  textAlign: TextAlign.right,
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
