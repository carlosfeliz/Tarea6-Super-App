import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String _temperature = '';
  String _weatherDescription = '';
  String _weatherIcon = '';  // Default URL
  bool _isLoading = true;

  Future<void> _fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=18.48&longitude=-69.90&current_weather=true'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final currentWeather = data['current_weather'];

      setState(() {
        _isLoading = false;
        _temperature = '${currentWeather['temperature']} °C';
        _weatherDescription = _getWeatherDescription(currentWeather['weathercode']);
        _weatherIcon = _getWeatherIcon(currentWeather['weathercode']);
      });
    } else {
      setState(() {
        _isLoading = false;
        _temperature = 'Failed to fetch temperature';
        _weatherDescription = 'N/A';
        _weatherIcon = 'https://via.placeholder.com/100.png?text=Unknown';
      });
    }
  }

  String _getWeatherDescription(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'Cielo Limpio';
      case 1:
        return 'Principalmente Claro';
      case 2:
        return 'Parcialmente Nublado';
      case 3:
        return 'Nublado';
      case 45:
      case 48:
        return 'Niebla';
      case 51:
      case 53:
      case 55:
        return 'Llovizna';
      case 61:
      case 63:
      case 65:
        return 'Lluvia';
      case 71:
      case 73:
      case 75:
        return 'Nieve';
      case 95:
      case 99:
        return 'Tormenta';
      default:
        return 'Desconocido';
    }
  }

  String _getWeatherIcon(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4IHBGQwRqf4xCHQwv9iokF4IRww7e-Kft7g&s';
      case 1:
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnXqvHvQkxdg6k0XWf6C-luOQFPjd09tlMeg&s';
      case 2:
        return 'https://s7d2.scene7.com/is/image/TWCNews/clouds_from_above';
      case 3:
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGLjVtnM7CSxP3wORLIQKHzb2sdyg4IPU4yQ&s';
      case 45:
      case 48:
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG7_CmKQX5eT__hW80R4goL0qex7_hVuBAbw&s';
      case 51:
      case 53:
      case 55:
        return 'https://www.fastweather.com/images/education/drizzle.jpg';
      case 61:
      case 63:
      case 65:
        return 'https://img.freepik.com/free-photo/rough-metallic-surface-texture_23-2148953930.jpg';
      case 71:
      case 73:
      case 75:
        return 'https://media.springernature.com/m685/springer-static/image/art%3A10.1038%2Fs41558-018-0332-5/MediaObjects/41558_2018_332_Figa_HTML.png';
      case 95:
      case 99:
        return 'https://www.thoughtco.com/thmb/U66MX1ZBcRS7WEqt3dH_LWnYwd0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-673747736-5b1989c3fa6bcc003614911a.jpg';
      default:
        return 'https://play.google.com/store/apps/details?id=ah.creativecodeapps.tiempo&hl=es_PY';
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
      appBar: AppBar(
        title: const Text('Tiempo en DR'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    _weatherIcon,
                    height: 300,
                    width: 300,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _temperature,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _weatherDescription,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
      ),
    );
  }
}
