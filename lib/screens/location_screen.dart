import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_live/utilities/constants.dart';
import 'package:weather_live/services/weather.dart';

import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather,this.aqidata});
  final locationweather;
  final aqidata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String SearchCity;
  String bgPath;
  String chk;
  String temp_msg;
  int temp;
  String cityName;
  String weatherIcon;
  String weatherCondition;
  int humidity;
  int pressure;
  double wind;
  double visbility;
  double aqi;
  int weatherdate;
  @override
  void initState() {
  //  print(widget.locationweather);
    super.initState();
    updateUI(widget.locationweather,widget.aqidata);
  }
  void updateUI(dynamic weatherdata , dynamic aqidata ){
    setState(() {
      if(weatherdata == null && aqidata == null){
        temp = 0;
        temp_msg = 'No message';
        cityName = 'Error';
        weatherIcon='Error';
        weatherCondition= 'Not Found';
        humidity =0;
        pressure =0;
        wind = 0.0;
        visbility =0;
        bgPath= 'images/background/default.jpg';
        aqi = 0.0;
        return;
      }

      double temprature = weatherdata['main']['temp'];
      temp = temprature.toInt();
      // temp_msg = weather.getMessage(temp);

      cityName = weatherdata['name'];

      var condition = weatherdata['weather'][0]['main'];
      var weathericon = weatherdata['weather'][0]['icon'];
      weatherIcon= weathericon;
      weatherCondition= condition;

      humidity = weatherdata['main']['humidity'];
      pressure = weatherdata['main']['pressure'];
      wind = weatherdata['wind']['speed'];

      var visbility_meter = weatherdata['visibility'];
      visbility = visbility_meter/1000 ;

      aqi = aqidata['list'][0]['components']['pm2_5'];
      bgPath = weather.getBgPath(weathericon);
      weatherdate = weatherdata['dt'];

      // weatherCondition= weather.getWeatherIcon(weathericon);
  });

  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,

              color: Colors.black,

            ),
            decoration: kTextFieldInputDecoration,
            onChanged: (value) {
              SearchCity = value;
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              //LoadingScreen()
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoadingScreen();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.location_on_sharp,
              size: 30,
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                if (SearchCity != null) {
                  var weatherdata = await weather.getCityWeather(SearchCity);
                  var aqidata = await weather.getCityAQI(SearchCity);
                  updateUI(weatherdata,aqidata);
                }
              },
              child: Icon(
                Icons.search,
                size: 40.0,
                color: Colors.white,
              ),
            )
          ],
        ),
      body:Stack(
        children: [
          Image.asset(bgPath,fit: BoxFit.cover,height: double.infinity,width: double.infinity,),

          ListView(
            children: [
            Container(
            height: height - (height/9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                  child: Text('$cityName',style: kCityTextStyle,textAlign: TextAlign.left,),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              'images/weather_icon/$weatherIcon.svg',
                              color: Colors.white,
                              width: 60,
                            ),
                            // Image(image:
                            //
                            // // AssetImage('images/weather_icon/$weatherIcon.png',),
                            //   height: 80,width: 80,),
                          ),
                          SizedBox(width: 20,),
                          Text(weatherCondition,
                            style: kWeatherTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        '$temp°c',
                        style: kTempTextStyle,
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text('Details',style: kDetailStyle,),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          weatherDetailCard(
                            image: 'images/humidity.png',
                            detailName: 'Humidity',
                            detailInfo: '$humidity%',
                          ),
                          SizedBox(width: 10,),
                          weatherDetailCard(
                            image: 'images/pressure-indicator.png',
                            detailName: 'Pressure',
                            detailInfo: '$pressure mbar',
                          ),
                          SizedBox(width: 10,),
                          weatherDetailCard(
                            image: 'images/air-quality.png',
                            detailName: 'AQI (PM 2.5)',
                            detailInfo: '$aqi',
                          ),
                        ],),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          weatherDetailCard(
                            image: 'images/wind.png',
                            detailName: 'Wind',
                            detailInfo: '$wind Km/h',
                          ),
                          SizedBox(width: 10,),
                          weatherDetailCard(
                            image: 'images/witness.png',
                            detailName: 'Visibility',
                            detailInfo: '$visbility Km',
                          ),
                        ],)
                    ],
                  ),
                ),
              ],
            ),
            ),
            SizedBox(height: 15,),
            Container(
            child: Text('Hourly Forcast',style: TextStyle( fontSize: 25),textAlign: TextAlign.center,),
            ),
            Container(
            child: hourlyForecast(
              temprature: '30',
              image:
                'images/weather_icon/01d.svg',
              time: '1:00',
            ),
            ),

            ],
            )
        ],
      )
    );
  }
}
class weatherDetailCard extends StatelessWidget {
  weatherDetailCard({this.image ,this.detailName , this.detailInfo });
  String image;
  String detailName;
  String detailInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: Color(	0xff888888).withOpacity(0.5),
          border: Border.all(
            color: Color(	0xff606060).withOpacity(1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Image(image: AssetImage(image),height: 40,width: 40,),
          Text(detailName,textAlign: TextAlign.center,),
          Text(detailInfo,textAlign: TextAlign.center,),
        ],
      ) ,
    );
  }
}

class hourlyForecast extends StatelessWidget {
  hourlyForecast({this.time ,this.image , this.temprature });
  String image;
  String time;
  String temprature;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: Color(	0xff888888).withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      height: 100,
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time,textAlign: TextAlign.center,),
          SvgPicture.asset(
            image,
            color: Colors.white,
            width: 30,
          ),
          Text(temprature,textAlign: TextAlign.center,),
        ],
      ) ,
    );
  }
}














