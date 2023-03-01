import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import './Constants.dart';


class SearchLocation{

  String key = apiKey; // openweathermap api key
  List locData = []; // list of the cities from search query of api


  Future<void> getLoc(String location) async {

    //main url of the api
    String uri = 'api.openweathermap.org';

    var locUrl = Uri.https(
        uri,
        //sub domains of the api
        '/geo/1.0/direct',

        //declaring query parameters of the api
        {
          'q' : location,
          'limit' : '10',
          'appid' : key
        }
    );

    //getting the Response from the api
    var locRes = await http.get(locUrl);

    //decoding the response in Json format
    //to parse the data
    List cords = jsonDecode(locRes.body);

    //adding the data from the api to the list of cities
    locData = cords;
    debugPrint('$locData');
  }

}



class ApiResponse with ChangeNotifier{

  final String key = apiKey; //openweathermap api key
  late double temp; //temperature of the location
  late int humidity; // humidity of the location
  late double airSpeed; // Air Speed of the location
  late String tempType; // Current Weather type
  late int aqi; // Air quality Index
  late String icon; // Icon of the current weather
  late String country; // name of the country
  late double maxTemp; // max Temp for the day
  late double minTemp; // min Temp for the day
  late String tempDescp; //description about the temperature
  late int timezone; // timezone of the said city
  late String city; // name of the city
  late String state; //name of the state
  late String date; //date of the said city


  Future<int> getLocation(String latitude, String longitude) async {

    //declared the main url
    String uri = 'api.openweathermap.org';
    var locUrl = Uri.https(
        uri,

        //sub domain of the api
        '/data/2.5/weather',

        //declaring the query parameters
        {
          'lat' : latitude,
          'lon' : longitude,
          'appid' : key,
          'units' : 'metric'
        }
    );

    //getting the Response from the api
    var response = await http.get(locUrl);

    //decoding the response in Json format
    //to parse the data
    Map data = jsonDecode(response.body);

    //getting time from the said timezone
    DateTime dateTime = DateTime.now();
    date = DateFormat.yMMMEd().format(dateTime);

    // getting temp description, icon
    List weather = data['weather'];
    Map weatherData = weather[0];
    tempType = weatherData['main'];
    tempDescp = weatherData['description'];
    icon = weatherData['icon'];

    //getting city
    city = data['name'];

    //getting country
    Map sys = data['sys'];
    country = sys['country'];

    //getting temp(°C), humidity(%),max,min
    Map mainData = data['main'];
    temp = mainData['temp'];
    humidity = mainData['humidity'];
    maxTemp = mainData['temp_max'].toDouble();


    // getting wind speed(m/s)
    Map speed = data['wind'];
    airSpeed = speed['speed'];

    return 1;

  }

}

