import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weathermodel.dart';
import 'package:weatherapp/services/weatherservice.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherservice = WeatherService();
  Weather? weather;
  fetchWeather() async {
    String cityname = await _weatherservice.getCity();
    try {
      final w = await _weatherservice.getWeather(cityname);
      setState(() {
        weather = w;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeather();
  }

  String getAnimation(String? condition) {
    if (condition == null) return 'assets/sun.json';
    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return 'assets/rain.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather?.cityName ?? "Loading City",
              style: const TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Lottie.asset(getAnimation(weather?.condition)),
            Text(
              weather?.temperature.round().toString() ?? "Loading Temperature",
              style: const TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Text(
              weather?.condition ?? "Loading Condition",
              style: const TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
