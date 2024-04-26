// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage ({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{

  final _weatherService = WeatherService("f6d38f90bca9d14759b32495ab42c99b");
  Weather? _weather;

  _fetchWeather() async {
    String cidade = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cidade);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cidade ?? "Carregando a cidade..."),
            Text("${_weather?.temperatura.round()}°C")
          ],
        ),
      ),  
    );
  }
}