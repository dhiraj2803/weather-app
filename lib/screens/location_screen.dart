import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_live/utilities/constants.dart';
import 'package:weather_live/services/weather.dart';
import 'package:http/http.dart' as http;
import 'loading_screen.dart';
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather,this.aqidata,this.dailyweather});
  final locationweather;
  final aqidata;
  final dailyweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();
//current weather variable
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
  var wind;
  double visbility;
  double aqi;
  int weatherdate;
// Daily weather variable
  //day
  String day1;
  String day2;
  String day3;
  String day4;
  String day5;
  //weather icon
  String dWeatherIcon1;
  String dWeatherIcon2;
  String dWeatherIcon3;
  String dWeatherIcon4;
  String dWeatherIcon5;
  //minimum temprature
  String dMinTemp1;
  String dMinTemp2;
  String dMinTemp3;
  String dMinTemp4;
  String dMinTemp5;
  //maximum temprature
  String dMaxTemp1;
  String dMaxTemp2;
  String dMaxTemp3;
  String dMaxTemp4;
  String dMaxTemp5;




  @override
  void initState() {
  //  print(widget.locationweather);
    super.initState();
    updateUI(widget.locationweather,widget.aqidata,widget.dailyweather);
  }
  void updateUI(dynamic weatherdata , dynamic aqidata ,dynamic dailyweather ){
    setState(() {
      if(weatherdata == null && aqidata == null){

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoadingScreen();
            },
          ),
        );
        // temp = 0;
        // temp_msg = 'No message';
        // cityName = 'Error';
        // weatherIcon='Error';
        // weatherCondition= 'Not Found';
        // humidity =0;
        // pressure =0;
        // wind = 0.0;
        // visbility =0;
        // bgPath= 'images/background/default.jpg';
        // aqi = 0.0;
        // return;
      }
      // current weather data
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
      //wind = windr.toDouble;

      var visbility_meter = weatherdata['visibility'];
      visbility = visbility_meter/1000 ;
      aqi = aqidata['list'][0]['components']['pm2_5'];
      bgPath = weather.getBgPath(weathericon);
      weatherdate = weatherdata['dt'];
      // weatherCondition= weather.getWeatherIcon(weathericon);

      // daily weather
      //day
       day1 = DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch( dailyweather['daily'][0]['dt']*1000000)).toString();
       day2 = DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch( dailyweather['daily'][1]['dt']*1000000)).toString();
       day3 = DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch( dailyweather['daily'][2]['dt']*1000000)).toString();
       day4 = DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch( dailyweather['daily'][3]['dt']*1000000)).toString();
       day5 = DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch( dailyweather['daily'][4]['dt']*1000000)).toString();
      //weather icon
       dWeatherIcon1 = dailyweather['daily'][0]['weather'][0]['icon'].toString();
       dWeatherIcon2 = dailyweather['daily'][1]['weather'][0]['icon'].toString();
       dWeatherIcon3 = dailyweather['daily'][2]['weather'][0]['icon'].toString();
       dWeatherIcon4 = dailyweather['daily'][3]['weather'][0]['icon'].toString();
       dWeatherIcon5 = dailyweather['daily'][4]['weather'][0]['icon'].toString();
      //minimum temprature
      double dMinTemp1r = dailyweather['daily'][0]['temp']['min'];
      double dMinTemp2r = dailyweather['daily'][1]['temp']['min'];
      double dMinTemp3r = dailyweather['daily'][2]['temp']['min'];
      double dMinTemp4r = dailyweather['daily'][3]['temp']['min'];
      double dMinTemp5r = dailyweather['daily'][4]['temp']['min'];
      int dMinTemp1i = dMinTemp1r.toInt();
      int dMinTemp2i = dMinTemp2r.toInt();
      int dMinTemp3i = dMinTemp3r.toInt();
      int dMinTemp4i = dMinTemp4r.toInt();
      int dMinTemp5i = dMinTemp5r.toInt();
      dMinTemp1 = dMinTemp1i.toString();
      dMinTemp2 = dMinTemp2i.toString();
      dMinTemp3 = dMinTemp3i.toString();
      dMinTemp4 = dMinTemp4i.toString();
      dMinTemp5 = dMinTemp5i.toString();
      //maximum temprature
      double dMaxTemp1r = dailyweather['daily'][0]['temp']['max'];
      double dMaxTemp2r = dailyweather['daily'][1]['temp']['max'];
      double dMaxTemp3r = dailyweather['daily'][2]['temp']['max'];
      double dMaxTemp4r = dailyweather['daily'][3]['temp']['max'];
      double dMaxTemp5r = dailyweather['daily'][4]['temp']['max'];
      int dMaxTemp1i = dMaxTemp1r.toInt();
      int dMaxTemp2i = dMaxTemp2r.toInt();
      int dMaxTemp3i = dMaxTemp3r.toInt();
      int dMaxTemp4i = dMaxTemp4r.toInt();
      int dMaxTemp5i = dMaxTemp5r.toInt();
      dMaxTemp1 = dMaxTemp1i.toString();
      dMaxTemp2 = dMaxTemp2i.toString();
      dMaxTemp3 = dMaxTemp3i.toString();
      dMaxTemp4 = dMaxTemp4i.toString();
      dMaxTemp5 = dMaxTemp5i.toString();


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
                  var dailyweather = await weather.getCityWeatherDaily(SearchCity);
                  updateUI(weatherdata,aqidata,dailyweather);
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
            height: height - (height/6),
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
                            detailInfo: '$visbility km',
                          ),
                        ],)
                    ],
                  ),
                ),
              ],
            ),
            ),
            SizedBox(height: 20,),
            Container(
            child: Text('5 Days Weather',style: TextStyle( fontSize: 25),textAlign: TextAlign.center,),
            ),
            SizedBox(height: 15),
            dailyForecast(
              temprature: '$dMinTemp1/$dMaxTemp1°C',
              image:
                'images/weather_icon/$dWeatherIcon1.svg',
              day: '$day1',
            ),
              SizedBox(height: 10),
              dailyForecast(
                temprature: '$dMinTemp2/$dMaxTemp2°C',
                image:
                'images/weather_icon/$dWeatherIcon2.svg',
                day: '$day2',
              ),
              SizedBox(height: 10),
              dailyForecast(
                temprature: '$dMinTemp3/$dMaxTemp3°C',
                image:
                'images/weather_icon/$dWeatherIcon3.svg',
                day: '$day3',
              ),
              SizedBox(height: 10),
              dailyForecast(
                temprature: '$dMinTemp4/$dMaxTemp4°C',
                image:
                'images/weather_icon/$dWeatherIcon4.svg',
                day: '$day4',
              ),
              SizedBox(height: 10),
              dailyForecast(
                temprature: '$dMinTemp5/$dMaxTemp5°C',
                image:
                'images/weather_icon/$dWeatherIcon5.svg',
                day: '$day5',
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
          Text("$detailInfo",textAlign: TextAlign.center,),
        ],
      ) ,
    );
  }
}

class dailyForecast extends StatelessWidget {
  dailyForecast({this.day ,this.image , this.temprature });
  String image;
  String day;
  String temprature;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
      decoration: BoxDecoration(
          color: Color(	0xff888888).withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      height: height/13,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day,textAlign: TextAlign.center,),
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