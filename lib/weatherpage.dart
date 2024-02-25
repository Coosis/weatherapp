import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weather?.cityName ?? "Loading City"),
            Text(weather?.temperature.round().toString() ??
                "Loading Temperature"),
          ],
        ),
      ),
    );
  }
}
