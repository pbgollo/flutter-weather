// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/services/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

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

  String getWeatherAnimation(String? condicao) {
    if(condicao == null) return "assets/sol.json";

    switch(condicao.toLowerCase()){
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/nuvem.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/sol-chuva.json";
      case "thunderstorm":
        return "assets/tempestade.json";
      case "clear":
        return "assets/sol.json";
      default:
        return "assets/sol.json";
    }
  }

  String getWeatherText(String? condicao) {
    if(condicao == null) return "Limpo";

    switch(condicao.toLowerCase()){
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "Nublado";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "Chuva";
      case "thunderstorm":
        return "Tempestade";
      case "clear":
        return "Limpo";
      default:
        return "Limpo";
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

            Icon(Icons.location_on,
              color: Colors.grey[500], 
              size: 25,
            ),

            const SizedBox(height: 5),

            Text(
              (_weather?.cidade ?? "Carregando a cidade...").toUpperCase(),
              style: GoogleFonts.bebasNeue(
                fontSize: 25,
                fontWeight: FontWeight.w400, 
                color: Colors.grey[500], 
              ),
            ),

            const SizedBox(height: 100),

            Lottie.asset(getWeatherAnimation(_weather?.condicao)),

            const SizedBox(height: 100),

            Text(
              ("${_weather?.temperatura.round()}°C").toUpperCase(),
              style: GoogleFonts.bebasNeue(
                fontSize: 50,
                fontWeight: FontWeight.bold, 
                color: Colors.grey[700], 
              ),
            ),

            Text(
              (getWeatherText(_weather?.condicao)).toUpperCase(),
              style: GoogleFonts.bebasNeue(
                fontSize: 25,
                fontWeight: FontWeight.w400, 
                color: Colors.grey[500], 
              ),

            ),
          ],
        ),
      ),  
    );
  }
}