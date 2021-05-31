import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
    fontFamily: 'ProductSans', fontSize: 120.0, fontWeight: FontWeight.normal);

const kMessageTextStyle = TextStyle(
  fontFamily: 'ProductSans',
  fontSize: 60.0,
);
const kCityTextStyle = TextStyle(
  fontFamily: 'ProductSans',
  fontSize: 30.0,
);
const kDetailStyle = TextStyle(
  fontFamily: 'ProductSans',
  fontSize: 22.0,
);

const kWeatherTextStyle = TextStyle(
  fontFamily: 'ProductSans',
  fontSize: 45.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'ProductSans',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(0),
  filled: true,
  fillColor: Colors.grey,
  hintText: 'Search ',
  hintStyle: TextStyle(color: Colors.white, fontSize: 25),
  labelStyle: TextStyle(fontSize: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
    borderSide: BorderSide.none,
  ),
);
