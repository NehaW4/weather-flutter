import 'package:flutter/material.dart';
import '../Constants.dart' as constant;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: constant.textSecondary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: size.height * 0.1,
              child: Text(constant.apiInstance.city,
                  style: TextStyle(
                    color: constant.textPrimary,
                    decoration: TextDecoration.none,
                  ))),
          Positioned(
              top: size.height * 0.2,
              child: Text(constant.apiInstance.date,
                  style: TextStyle(
                    color: constant.textPrimary,
                    decoration: TextDecoration.none,
                    fontSize: 30,
                  ))),
          Positioned(
            top: size.height * 0.3,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.23,
              child: Image.network(
                'http://openweathermap.org/img/wn/${constant.apiInstance.icon}@2x.png',
                scale: 0.2,
              ),
              color: Colors.blue
            ),
          ),
          Positioned(
            top: size.height * 0.6,
            child: Text(
              '${constant.apiInstance.temp}°c',
              style: TextStyle(
                fontSize: size.width * 0.16,
                decoration: TextDecoration.none,
                color: constant.textPrimary,
              ),
            ),
          ),
          Positioned(
              bottom: size.height * 0.03,
              child: Row(
                children: [
                  extraInfo(
                      size: size,
                      icon: Icons.thermostat,
                      name: 'MaxTemp',
                      value: '${constant.apiInstance.maxTemp}°c'),
                  extraInfo(
                      value: '${constant.apiInstance.airSpeed}m/s',
                      name: 'Windspeed',
                      icon: Icons.air_outlined,
                      size: size),
                  extraInfo(
                      value: '${constant.apiInstance.humidity}%',
                      name: 'Humidity',
                      icon: Icons.percent,
                      size: size),
                ],
              ))
        ],
      ),
    );
  }
}

class extraInfo extends StatelessWidget {
  const extraInfo({
    super.key,
    required this.value,
    required this.name,
    required this.icon,
    required this.size,
  });

  final Size size;
  final String value;
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.3,
      child: Column(
        children: [
          Icon(icon),
          Text(name,
              style: TextStyle(
                color: constant.textPrimary,
                decoration: TextDecoration.none,
                fontSize: 20,
              )),
          Text(value,
              style: TextStyle(
                color: constant.textPrimary,
                decoration: TextDecoration.none,
                fontSize: 15,
              ))
        ],
      ),
    );
  }
}
