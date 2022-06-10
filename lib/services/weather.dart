import 'package:weather_app1/services/location.dart';
import 'package:weather_app1/services/networking.dart';

const apikey = '5cbb2eb3354ea0636e442da0aaa9e518';
const openMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<String> getCityNameWeather(String cityName) async {
    NetworkHelper weather =
        NetworkHelper('$openMapURL?q=$cityName&appid=$apikey&units=metric');
    var cityWeatherData = await weather.getData();
    return cityWeatherData;
  }

  Future<String> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    // myLat = location.latitude;
    // myLon = location.longitude;
    String myUrl =
        '$openMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric';
    NetworkHelper weather = NetworkHelper(myUrl);
    var weatherData = await weather.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
