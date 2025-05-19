import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Utama")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Weather Page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WeatherScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "Jember";
  String apiKey = "a6db33ff7efc38aaf61e214f70d5d0c7";
  String weatherDescription = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        weatherDescription =
            "${data['weather'][0]['description']} (${data['main']['temp']}°C)";
      });
    } else {
      setState(() {
        weatherDescription = "Failed to load weather";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cuaca di $city")),
      body: Center(child: Text(weatherDescription)),
    );
  }
}
