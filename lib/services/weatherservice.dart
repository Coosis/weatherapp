import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASEURL =
      'api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=8efdf2e7be42ded34f2900b2b4f20f05';
  static const KEY = '8efdf2e7be42ded34f2900b2b4f20f05';

  WeatherService();

  Future<Weather> getWeather(String cityName) async {
    final result = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$KEY&units=metric'));
    if (result.statusCode != 200)
      throw Exception("Failed to load weather data");
    return Weather.fromJson(jsonDecode(result.body));
  }

  Future<String> getCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isNotEmpty) {
      String? cityName = placemarks[0].locality;
      return cityName ?? "";
    } else {
      // Handle the case where no placemarks are found
      return "No city found";
    }
  }
}
