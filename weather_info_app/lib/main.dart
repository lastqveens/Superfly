import 'package:flutter/material.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = '';
  String weatherCondition = 'Unknown';
  String temperature = '--';

  final TextEditingController cityController = TextEditingController();

  void fetchWeather() {
    setState(() {
      // Simulate fetching weather data
      cityName = cityController.text;
      weatherCondition = 'Sunny'; // Placeholder for actual data
      temperature = '25°C';       // Placeholder for actual data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text('Fetch Weather'),
            ),
            SizedBox(height: 32),
            // Weather data display
            Text(
              'City: $cityName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Temperature: $temperature',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Weather Condition: $weatherCondition',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
