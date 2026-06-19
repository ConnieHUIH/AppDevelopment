import 'package:flutter/material.dart';
import 'package:flutter_application_weatherapp/models/weather_model.dart';
import 'package:flutter_application_weatherapp/services/weather_services.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key for openweathermap
  final _weatherService = WeatherService('YOUR_API_KEY_HERE');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("The user denied the location permission.");
          return;
        }
      }
    // get the current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("Current location: ${position.latitude}, ${position.longitude}");

    // get weather for location
      final weather = await _weatherService.getWeather(position.latitude, position.longitude);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print("Some mistake occurred when getting the weather: $e");
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Weather-sunny.json'; // default animation to sunny
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return 'assets/Weather-sunny.json';
      case 'clouds':
      case 'mist':
      case 'fog':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/Weather-partly cloudy.json';
      case 'rain':
        return 'assets/rainy icon.json';
      case 'snow':
        return 'assets/Weather-snow.json';
      case 'thunderstorm':
      case 'thunder':
        return 'assets/Weather-storm.json';
      case 'drizzle':
        return 'assets/Weather-partly shower.json';
      case 'windy':
        return 'assets/Weather-windy.json';
      default:
        return 'assets/Weather-sunny.json'; // default animation
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 183, 206),
      appBar: AppBar(
        title: const Text('Weather Forecast',
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 90, 122, 149),
        foregroundColor: const Color.fromARGB(255, 238, 217, 240),
        elevation: 3,
      ),
      
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "loading city..."),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text(_weather != null ? '${_weather!.temperature.round()}°C' : '--°C'),
            
            // weather condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}