import 'package:weather_live/services/location.dart';
import 'package:weather_live/services/networking.dart';

const APIkey = 'ae07d0de632aa06e3c1c0f20f23285e9';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIkey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityAQI(String cityName) async {
    // double latitude;
    // double longitude;
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIkey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    if (weatherData != null) {
      double Lon = weatherData['coord']['lon'];
      double Lat = weatherData['coord']['lat'];
      // latitude = lat.toInt();
      NetworkHelperaqi networkHelperaqi = NetworkHelperaqi(
          'http://api.openweathermap.org/data/2.5/air_pollution?lat=$Lat&lon=$Lon&appid=$APIkey');
      var aqiData = await networkHelperaqi.getData();
      return aqiData;
    } else {
      return null;
    }
    //return weatherData;
  }

  Future<dynamic> getCityWeatherDaily(String cityName) async {
    // double latitude;
    // double longitude;
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIkey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    if (weatherData != null) {
      double Lon = weatherData['coord']['lon'];
      double Lat = weatherData['coord']['lat'];
      // latitude = lat.toInt();
      NetworkHelperforecast networkHelperforecast = NetworkHelperforecast(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$Lat&lon=$Lon&exclude=minutely,hourly,alerts&appid=$APIkey&units=metric');
      var weatherDataDaily = await networkHelperforecast.getData();
      return weatherDataDaily;
    } else {
      return null;
    }
    //return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$APIkey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationAQI() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelperaqi networkHelperaqi = NetworkHelperaqi(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${location.latitude}&lon=${location.longitude}&appid=$APIkey');
    var aqiData = await networkHelperaqi.getData();
    return aqiData;
    //print(aqiData);
    //http://api.openweathermap.org/data/2.5/air_pollution?lat={lat}&lon={lon}&appid={API key}
  }

  Future<dynamic> getLocationWeatherDaily() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelperforecast networkHelperforecast = NetworkHelperforecast(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely,hourly,alerts&appid=$APIkey&units=metric');
    var weatherDataDaily = await networkHelperforecast.getData();
    return weatherDataDaily;
  }

  String getWeatherIcon(String icon_code) {
    if (icon_code == '01d' || icon_code == '01n') {
      return 'Clear sky';
    } else if (icon_code == '02d' || icon_code == '02n') {
      return 'Few clouds';
    } else if (icon_code == '03d' || icon_code == '03n') {
      return 'Scattered clouds';
    } else if (icon_code == '04d' || icon_code == '04n') {
      return 'Broken clouds';
    } else if (icon_code == '09d' || icon_code == '09n') {
      return 'Shower rain';
    } else if (icon_code == '10d' || icon_code == '10n') {
      return 'Rain';
    } else if (icon_code == '11d' || icon_code == '11n') {
      return 'Thunderstorm';
    } else if (icon_code == '13d' || icon_code == '13n') {
      return 'Snow';
    } else if (icon_code == '50d' || icon_code == '50n') {
      return 'Mist';
    }
  }

  String getBgPath(String icon_code) {
    if (icon_code == '01d') {
      return 'images/background/clear_day.jpg';
    } else if (icon_code == '01n') {
      return 'images/background/clear_night.jpg';
    } else if (icon_code == '02d' || icon_code == '03d' || icon_code == '04d') {
      return 'images/background/Clouds_day.jpg';
    } else if (icon_code == '02n' || icon_code == '03n' || icon_code == '04n') {
      return 'images/background/Clouds_night.jpg';
    } else if (icon_code == '09d' || icon_code == '09n') {
      return 'images/background/Drizzle.jpg';
    } else if (icon_code == '10d' || icon_code == '10n') {
      return 'images/background/rainy.jpg';
    } else if (icon_code == '11d' || icon_code == '11n') {
      return 'images/background/Thunderstorm.jpg';
    } else if (icon_code == '13d' || icon_code == '13n') {
      return 'images/background/Snow.jpg';
    } else if (icon_code == '50d' || icon_code == '50n') {
      return 'images/background/default.jpg';
    }
  }
}
