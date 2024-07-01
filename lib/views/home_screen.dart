import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/views/weather_screen.dart';
import 'package:weather_app/widgets/city_search_widget.dart';

// HomeScreen is a stateful widget that uses Riverpod for state management
class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// State class for HomeScreen
class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Controller for the text field to input city name
  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLastCity(); // Load the last searched city when the screen initializes
  }

  // Load the last searched city from shared preferences
  void _loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCity = prefs.getString('lastCity');
    if (lastCity != null) {
      setState(() {
        _cityController.text = lastCity;
      });
    }
  }

  // Save the last searched city to shared preferences
  void _saveLastCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastCity', city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'), // Title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Widget to search for cities
            CitySearchWidget(controller: _cityController),
            SizedBox(height: 16),
            // Button to fetch weather for the entered city
            ElevatedButton(
              onPressed: () {
                _saveLastCity(_cityController.text); // Save the entered city
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherScreen(cityName: _cityController.text),
                  ),
                );
              },
              child: Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
