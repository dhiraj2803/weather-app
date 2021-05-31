import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_live/screens/location_screen.dart';
import 'package:weather_live/services/weather.dart';
import 'package:weather_live/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocationdata();
    super.initState();
  }

  void getLocationdata() async {

   var weatherData = await WeatherModel().getLocationWeather();
   var aqiData = await WeatherModel().getLocationAQI();
   var weatherForecast = await WeatherModel().getLocationWeatherDaily();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationweather: weatherData,
        aqidata: aqiData,
        dailyweather: weatherForecast,
      );
    }));
    //print(networkHelper.getData());
  }

//

  // Build
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitDualRing(
              color: Colors.redAccent,
              size: 50.0,
              duration: Duration(seconds: 2),
            ),
            SizedBox(height: 20,),
            Text('Getting weather',style: kButtonTextStyle,),
          ],
        ),
      ),
    );
  }
}
